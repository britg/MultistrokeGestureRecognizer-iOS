//
//  WTMGlyph.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyph.h"


@implementation WTMGlyph

@synthesize name;
@synthesize strokes;
@synthesize unistrokes;

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

- (id)initWithName:(NSString *)_name strokes:(NSArray *)_strokes {
    [self init];
    self.name = _name;
    self.strokes = _strokes;
    [self createUnistrokes];
    return self;
}

// Calculate all permutations of unistrokes from the points
- (void)createUnistrokes {
    
}

// Do the permutations
- (void)heapPermute {
    
}

@end
