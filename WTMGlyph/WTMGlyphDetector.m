//
//  WTMGlyphDetector.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyphDetector.h"
#import "WTMGlyphDefaults.h"
#import "WTMGlyphStroke.h"


@implementation WTMGlyphDetector

@synthesize points;
@synthesize activeStroke;
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

- (void)dealloc {
    [points release];
    [strokes release];
    [activeStroke release];
    
    [super dealloc];
}

#pragma mark - Points

- (void)addPoint:(CGPoint)point {
    DebugLog(@"Adding point to detector: %@", [NSValue valueWithCGPoint:point]);
    
    lastPointTime = [[NSDate date] timeIntervalSince1970];
    
    [self.points addObject:[NSValue valueWithCGPoint:point]];
    [self.activeStroke addPoint:point];
}

#pragma mark - Strokes

- (void)strokeDidBegin {
    DebugLog(@"Stroke did begin");
    self.activeStroke = [[WTMGlyphStroke alloc] init];
}

- (void)strokeDidEnd {
    DebugLog(@"Stroke did end");
    WTMGlyphStroke *strokeCopy = [self.activeStroke copy];
    DebugLog(@"Copy of stroke  has %i points", strokeCopy.points.count);
    [strokes addObject:strokeCopy];
    self.activeStroke = nil;
}

#pragma mark - Utilities

- (void)resetIfTimeout {
    if (points.count < 1) {
        return;
    }
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSInteger elapsed = now - lastPointTime;
    
    //DebugLog(@"Elapsed time since last point is: %i", elapsed);
    if (elapsed >= self.timeoutSeconds) {
        DebugLog(@"Timeout detected, resetting");
        [self reset];
    }
}

- (void)reset {
    [self.points removeAllObjects];
    [strokes removeAllObjects];
    self.activeStroke = nil;
}

@end
