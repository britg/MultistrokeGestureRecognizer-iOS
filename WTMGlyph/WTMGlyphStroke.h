//
//  WTMGlyphStroke.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/14/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WTMGlyphStroke : NSObject {
    NSMutableArray *points;
}

@property (nonatomic, strong) NSMutableArray *points;

- (id)initWithPoints:(NSArray *)_points;
- (void)addPoint:(CGPoint)point;


@end
