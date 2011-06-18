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

@synthesize points;
@synthesize glyphs;
@synthesize timeoutSeconds;

#pragma mark - Lifecycle

+ (id)detector {
    WTMGlyphDetector *detector = [[WTMGlyphDetector alloc] init];
    return detector;
}

+ (id)defaultDetector {
    WTMGlyphDetector *detector = [[WTMGlyphDetector alloc] initWithDefaultGlyphs];
    return detector;
}

- (id)init {
    if ((self = [super init])) {
        self.points = [[NSMutableArray alloc] init];
        self.timeoutSeconds = WTMGlyphDefaultTimeoutSeconds;
        lastPointTime = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

- (id)initWithGlyphs:(NSArray *)_glyphs {
    [self init];
    self.glyphs = [NSMutableArray arrayWithArray:_glyphs];
    return self;
}

- (id)initWithDefaultGlyphs {
    [self init];
    
    NSData *jsonData;
    NSArray *fileNames = [NSArray arrayWithObjects: @"T", nil];
    
    for (int i = 0; i < fileNames.count; i++) {
        NSString *name = [fileNames objectAtIndex:i];
        jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"json"]];
        [self addGlyphFromJSON:jsonData name:name];
    }
    
    return self;
}

- (void)dealloc {
    [points release];
    [glyphs release];
    
    [super dealloc];
}

#pragma mark - Glyph Templates

- (void)addGlyph:(WTMGlyph *)glyph {
    if (!self.glyphs)
        self.glyphs = [NSMutableArray arrayWithCapacity:1];

    [self.glyphs addObject:glyph];
}


- (void)addGlyphFromJSON:(NSData *)jsonData name:(NSString *)name {
    WTMGlyph *t = [[WTMGlyph alloc] initWithName:name JSONData:jsonData];
    [self addGlyph:t];
}

- (void)removeGlyphByName:(NSString *)name {
    NSEnumerator *eachGlyph = [self.glyphs objectEnumerator];
    WTMGlyph *glyph;
    
    while ((glyph = (WTMGlyph *)[eachGlyph nextObject])) {
        if ([glyph.name isEqualToString:name]) {
            [self.glyphs removeObject:glyph];
        }
    }
}


#pragma mark - Detection

- (void)addPoint:(CGPoint)point {
    //DebugLog(@"Adding point to detector: %@", [NSValue valueWithCGPoint:point]);
    
    lastPointTime = [[NSDate date] timeIntervalSince1970];
    
    [self.points addObject:[NSValue valueWithCGPoint:point]];
}

- (void)detectGlyph {
    
    // Take the captured points and make a Template
    // Compare the template against existing templates and find the best match.
    // If the best match is within a threshold, consider it a true match.
    
    WTMGlyphTemplate *inputTemplate = [[WTMGlyphTemplate alloc] initWithName:@"Input" points:self.points];
    WTMGlyph *glyph;
    NSEnumerator *eachGlyph = [self.glyphs objectEnumerator];
    WTMGlyph *bestMatch;
    float highestScore = 0;
    
    while ((glyph = (WTMGlyph *)[eachGlyph nextObject])) {
        float score = 1 / [glyph recognize:inputTemplate];
        if (score > highestScore) {
            highestScore = score;
            bestMatch = glyph;
        }
    }
    DebugLog(@"Glyph detected! %@ with a score of %f", bestMatch.name, highestScore);
    [delegate glyphDetected:bestMatch];
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
    
    //DebugLog(@"Elapsed time since last point is: %i", elapsed);
    if (elapsed >= self.timeoutSeconds) {
        DebugLog(@"Timeout detected");
        return YES;
    }
    
    return NO;
}

- (void)reset {
    [self.points removeAllObjects];
}

@end
