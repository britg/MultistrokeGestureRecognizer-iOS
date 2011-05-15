//
//  WTMGlyphT.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/15/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyphT.h"
#import "WTMGlyphStroke.h"


@implementation WTMGlyphT

+ (id)glyph {
    self = [[WTMGlyph alloc] initWithName:@"T" strokes:[WTMGlyphT strokes]];
    return self;
}

+ (NSMutableArray *)strokes {
    NSMutableArray *_strokes = [NSMutableArray array];
    
    WTMGlyphStroke *stroke1;
    WTMGlyphStroke *stroke2;
    
    NSValue *pointValue1 = [NSValue valueWithCGPoint:CGPointMake(30, 7)];
    NSValue *pointValue2 = [NSValue valueWithCGPoint:CGPointMake(103, 7)];
    NSValue *pointValue3 = [NSValue valueWithCGPoint:CGPointMake(66, 7)];
    NSValue *pointValue4 = [NSValue valueWithCGPoint:CGPointMake(66, 87)];
    
    stroke1 = [[WTMGlyphStroke alloc] initWithPoints:[NSArray arrayWithObjects:pointValue1, pointValue2, nil]];
    stroke2 = [[WTMGlyphStroke alloc] initWithPoints:[NSArray arrayWithObjects:pointValue3, pointValue4, nil]];
    
    _strokes = [NSMutableArray arrayWithObjects:stroke1, stroke2, nil];
    
    return _strokes;
}


@end
