//
//  WTMGlyphTemplate.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/15/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//
//  A collection of points representing the unistroke of a
//  multistroke.

#import "WTMGlyphTemplate.h"


@implementation WTMGlyphTemplate

@synthesize name;
@synthesize points;

- (id)initWithName:(NSString *)_name points:(NSArray *)_points {
    if ((self = [super init])) {
        self.name = _name;
        self.points = [NSMutableArray arrayWithArray:_points];
    }
    
    return self;
}

@end
