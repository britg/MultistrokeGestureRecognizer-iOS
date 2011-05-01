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
        strokes = [[NSMutableArray alloc] init];
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
    //DebugLog(@"Adding point to detector: %@", [NSValue valueWithCGPoint:point]);
    
    lastPointTime = [[NSDate date] timeIntervalSince1970];
    
    if([self isInflectionPoint: point]) {
        DebugLog(@"Inflection Point detected");
        [self strokeDidEnd];
        [self strokeDidBegin];
    }
    
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
    if (!self.activeStroke) {
        return;
    }
    WTMGlyphStroke *strokeCopy = [self.activeStroke copy];
    [strokes addObject:strokeCopy];
    self.activeStroke = nil;
}

- (void)strokeDidEndWithTouchUp {
    [self strokeDidEnd];
    [self analyzeStrokes];
}

- (BOOL)isInflectionPoint:(CGPoint)point {
    if (self.activeStroke.points.count < WTMGlyphMinInflectionPointCount) {
        return NO;
    }
    
    NSValue *lastValue = [self.activeStroke.points objectAtIndex:self.activeStroke.points.count-1];
    CGPoint lastPoint = [lastValue CGPointValue];
    
    NSValue *secondToLastValue = [self.activeStroke.points objectAtIndex:self.activeStroke.points.count-2];
    CGPoint secondToLastPoint = [secondToLastValue CGPointValue];
    
    int xDelta = lastPoint.x - secondToLastPoint.x;
    int yDelta = lastPoint.y - secondToLastPoint.y;
    
    int xNext = point.x - lastPoint.x;
    int yNext = point.y - lastPoint.y;
    
    return ((xDelta < 0 && xNext > 0) 
            || (xDelta > 0 && xNext < 0)
            || (yDelta > 0 && yNext < 0)
            || (yDelta < 0 && yNext > 0));
}

- (void)analyzeStrokes {
    DebugLog(@"Analyzing strokes with count %i", strokes.count);
    
    NSMutableArray *strokeTypes = [NSMutableArray arrayWithCapacity:strokes.count];
    
    for (WTMGlyphStroke *stroke in strokes) {
        WTMGlyphStrokeType strokeType = [stroke analyzeStroke];
        [strokeTypes addObject:[NSNumber numberWithInt:strokeType]];
    }
    
    DebugLog(@"Stroke types are: %@", strokeTypes);
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
