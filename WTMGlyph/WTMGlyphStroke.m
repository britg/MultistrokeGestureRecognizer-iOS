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

- (void)dealloc {
    [points release];
}

- (id)initWithPoints:(NSArray *)_points {
    if ((self = [super init])) {
        self.points = [NSArray arrayWithArray:_points];
    }
    return self;
}

@end
