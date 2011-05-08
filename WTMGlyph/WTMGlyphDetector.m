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
@synthesize templates;
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

- (id)initWithGlyphTemplates:(NSArray *)_templates {
    [self init];
    self.templates = [NSMutableArray arrayWithArray:_templates];
    return self;
}

- (void)dealloc {
    [points release];
    [templates release];
    
    [super dealloc];
}

#pragma mark - Detection

- (void)addPoint:(CGPoint)point {
    //DebugLog(@"Adding point to detector: %@", [NSValue valueWithCGPoint:point]);
    
    lastPointTime = [[NSDate date] timeIntervalSince1970];
    
    [self.points addObject:[NSValue valueWithCGPoint:point]];
}

- (void)detectGlyph {
    
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
}

@end
