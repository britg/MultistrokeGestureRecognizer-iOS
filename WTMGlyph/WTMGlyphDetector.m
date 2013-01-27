//
//  WTMGlyphDetector.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyphDetector.h"
#import "WTMGlyphDefaults.h"
#import "WTMGlyphTemplate.h"


@implementation WTMGlyphDetector

@synthesize delegate;
@synthesize points;
@synthesize glyphs;
@synthesize timeoutSeconds;

#pragma mark - Lifecycle

+ (id)detector 
{
    return [[WTMGlyphDetector alloc] init];
}

+ (id)defaultDetector 
{
    return [[WTMGlyphDetector alloc] initWithDefaultGlyphs];
}

- (id)init 
{
    if ((self = [super init])) {
        self.points = [[NSMutableArray alloc] init];
        self.glyphs = [[NSMutableArray alloc] init];
        self.timeoutSeconds = WTMGlyphDefaultTimeoutSeconds;
        lastPointTime = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

- (id)initWithGlyphs:(NSArray *)_glyphs {
    if (!(self = [self init])) return nil;
    self.glyphs = [NSMutableArray arrayWithArray:_glyphs];
    return self;
}

- (id)initWithDefaultGlyphs {
    self = [self init];
    if (self) {
        NSData *jsonData;
        NSArray *fileNames = [NSArray arrayWithObjects: @"D", @"T", @"N", @"P", nil];

        for (int i = 0; i < fileNames.count; i++) {
            NSString *name = [fileNames objectAtIndex:i];
            jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"json"]];        
            if (jsonData) {
                [self addGlyphFromJSON:jsonData name:name];
            }
        }
    }
    return self;
}


#pragma mark - Glyph Templates

- (void)addGlyph:(WTMGlyph *)glyph 
{
    if (!self.glyphs)
        self.glyphs = [NSMutableArray arrayWithCapacity:1];

    [self.glyphs addObject:glyph];
}


- (void)addGlyphFromJSON:(NSData *)jsonData name:(NSString *)name 
{
    WTMGlyph *t = [[WTMGlyph alloc] initWithName:name JSONData:jsonData];
    [self addGlyph:t];
}

- (void)removeGlyphByName:(NSString *)name 
{
    NSEnumerator *eachGlyph = [self.glyphs objectEnumerator];
    WTMGlyph *glyph;
    
    while ((glyph = (WTMGlyph *)[eachGlyph nextObject])) {
        if ([glyph.name isEqualToString:name]) {
            [self.glyphs removeObject:glyph];
        }
    }
}

- (void)removeAllGlyphs 
{
    [self.glyphs removeAllObjects];
}


#pragma mark - Detection

- (void)addPoint:(CGPoint)point {
    DebugLog(@"Adding point to detector: %@", [NSValue valueWithCGPoint:point]);
    
    lastPointTime = [[NSDate date] timeIntervalSince1970];
    
    [self.points addObject:[NSValue valueWithCGPoint:point]];
}

- (void)removeAllPoints {
    [self.points removeAllObjects];
}

- (WTMDetectionResult*)detectGlyph {
    
    // Take the captured points and make a Template
    // Compare the template against existing templates and find the best match.
    // If the best match is within a threshold, consider it a true match.
    WTMDetectionResult * d = [[WTMDetectionResult alloc] init];
    d.allScores = nil;
    d.bestMatch = nil;

    if (![self hasEnoughPoints]) {
        d.success = NO;
        return d;
    }
    
    if (self.glyphs.count < 1) {
        d.success = NO;
        return d;
    }
    
    WTMGlyphTemplate *inputTemplate = [[WTMGlyphTemplate alloc] initWithName:@"Input" points:self.points];
    WTMGlyph *glyph = nil;
    NSEnumerator *eachGlyph = [self.glyphs objectEnumerator];
    WTMGlyph *bestMatch;
    float highestScore = 0;
    
    NSMutableArray *results = [NSMutableArray array];
    NSDictionary *result;
    
    while ((glyph = (WTMGlyph *)[eachGlyph nextObject])) {
        float score = 1 / [glyph recognize:inputTemplate];
        DebugLog(@"Glyph: %@ Score: %f", glyph.name, score);
        result = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:glyph.name, [NSNumber numberWithFloat:score], nil] 
                                             forKeys:[NSArray arrayWithObjects:@"name", @"score", nil]];
        [results addObject:result];
        
        if (score > highestScore) {
            highestScore = score;
            bestMatch = glyph;
        }
    }
    DebugLog(@"Best Glyph: %@ with a Score of: %f", bestMatch.name, highestScore);
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
    NSArray *sortedResults = [results sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    d.success = YES;
    d.allScores = sortedResults;
    d.bestMatch = bestMatch;
    d.bestScore = highestScore;
    
    if ([delegate respondsToSelector: @selector(glyphDetected:withScore:)])
        [delegate glyphDetected:bestMatch withScore:highestScore];
    if ([delegate respondsToSelector:@selector(glyphResults:)])
        [delegate glyphResults:sortedResults];
    
    return d;
}

- (NSArray *)resample:(NSArray *)_points {
    // todo: resample!
    return self.points;
}

- (NSArray *)translate:(NSArray *)_points {
    // todo: translate!
    return self.points;
}

- (NSArray *)vectorize:(NSArray *)_points {
    // todo: vectorize!
    return self.points;
}

#pragma mark - Utilities

- (void)detectIfTimedOut {
    if ([self hasTimedOut]) {
        DebugLog(@"Running detection");
        [self detectGlyph];
    }
}

- (void)resetIfTimedOut {
    if ([self hasTimedOut])
        [self reset];
}

- (BOOL)hasTimedOut {
    if (points.count < 1) {
        return NO;
    }
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSInteger elapsed = now - lastPointTime;
    
    DebugLog(@"Elapsed time since last point is: %i", elapsed);
    if (elapsed >= self.timeoutSeconds) {
        DebugLog(@"Timeout detected");
        return YES;
    }
    
    return NO;
}

- (BOOL)hasEnoughPoints {
    return (self.points.count >= WTMGlyphMinPoints);
}

- (void)reset {
    [self.points removeAllObjects];
}

@end
