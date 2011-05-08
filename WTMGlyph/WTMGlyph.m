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
@synthesize templatePoints;

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

- (id)initWithName:(NSString *)_name templatePoints:(NSArray *)points {
    [self init];
    self.name = _name;
    self.templatePoints = points;
    
    return self;
}

@end
