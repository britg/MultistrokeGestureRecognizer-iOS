//
//  WTMGlyphDetector.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyphDetector.h"


@implementation WTMGlyphDetector

@synthesize points;

+ (id)detector {
    return [[WTMGlyphDetector alloc] init];
}

- (void)dealloc {
    [points release];
    
    [super dealloc];
}

- (void)addPoint:(CGPoint)point {
    
}

@end
