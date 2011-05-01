//
//  WTMGlyphStroke.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyphStroke.h"


@implementation WTMGlyphStroke

@synthesize points;

#pragma mark - Lifecycle

- (void)dealloc {
    [points release];
    
    [super dealloc];
}

- (id)init{
    if((self = [super init])) {
        self.points = [NSMutableArray array];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    WTMGlyphStroke *copy = [[WTMGlyphStroke alloc] init];
    copy.points = self.points;
    return copy;
}

#pragma mark - Points

- (void)addPoint:(CGPoint)point {
    NSValue *pointValue = [NSValue valueWithCGPoint:point];
    [self.points addObject:pointValue];
}

#pragma mark - Stroke Analysis

- (WTMGlyphStrokeType)analyzeStroke {
    return WTMGlyphStrokeTypeEast;
}


@end
