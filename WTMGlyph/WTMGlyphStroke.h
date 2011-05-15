//
//  WTMGlyphStroke.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/14/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WTMGlyphStroke : NSObject {
    NSArray *points;
}

@property (nonatomic, retain) NSArray *points;

- (id)initWithPoints:(NSArray *)_points;

@end
