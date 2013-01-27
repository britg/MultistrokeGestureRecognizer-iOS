//
//  WTMGlyphStroke.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/14/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyphStroke.h"


@implementation WTMGlyphStroke
@synthesize points;


- (id)initWithPoints:(NSArray *)_points {
    if ((self = [super init])) {
        self.points = [NSMutableArray arrayWithArray:_points];
    }
    return self;
}

- (void)addPoint:(CGPoint)point {
    if (!self.points)
        self.points = [NSMutableArray array];
    
    [self.points addObject:[NSValue valueWithCGPoint:point]];
}

@end
