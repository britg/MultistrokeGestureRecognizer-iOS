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

#pragma mark - Lifecycle

- (void)dealloc {
    [name release];
    [strokes release];
    [unistrokes release];
    
    [super dealloc];
}

- (id)init {
    if ((self = [super init])) {

    }
    return self;
}

- (id)initWithName:(NSString *)_name strokes:(NSMutableArray *)_strokes {
    [self init];
    self.name = _name;
    self.strokes = _strokes;
    [self createUnistrokes];
    return self;
}

#pragma mark - Initialization

// Calculate all permutations of unistrokes from the points
- (void)createUnistrokes {
    // permute over all possible directions (heapPermute)
    // create WTMGlyphTemplates from all unistrokes
    
}

// Do the permutations
- (void)heapPermute {
    
}

#pragma mark - On-the-fly creation

- (void)addPoint:(CGPoint)point {
    
}

- (void)startStroke {
    
}

- (void)endStroke {
    
}

@end
