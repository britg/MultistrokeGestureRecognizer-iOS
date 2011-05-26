//
//  WTMGlyphDetector.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyphDetector.h"
#import "WTMGlyphDefaults.h"


@implementation WTMGlyphDetector

@synthesize points;
@synthesize glyphs;
@synthesize timeoutSeconds;

#pragma mark - Lifecycle

+ (id)detector {
    WTMGlyphDetector *detector = [[WTMGlyphDetector alloc] init];
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

- (void)removeGlyphByName:(NSString *)name {
    NSEnumerator *eachGlyph = [self.glyphs objectEnumerator];
    WTMGlyph *glyph;
    
    while ((glyph = (WTMGlyph *)[eachGlyph nextObject])) {
        if ([glyph.name isEqualToString:name]) {
            [self.glyphs removeObject:glyph];
        }
    }
}

- (void)addDefaultGlyphs {
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"t" ofType:@"json"]];
    DebugLog(@"JSON data from file", jsonData);
    WTMGlyph *t = [[WTMGlyph alloc] initWithName:@"t" JSONData:jsonData];
    [self addGlyph:t];
}

#pragma mark - Detection

- (void)addPoint:(CGPoint)point {
    //DebugLog(@"Adding point to detector: %@", [NSValue valueWithCGPoint:point]);
    
    lastPointTime = [[NSDate date] timeIntervalSince1970];
    
    [self.points addObject:[NSValue valueWithCGPoint:point]];
}

- (void)detectGlyph {
    NSArray *resampled = [self resample:self.points];
    NSArray *translated = [self translate:resampled];
    NSArray *vectorized = [self vectorize:translated];
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
