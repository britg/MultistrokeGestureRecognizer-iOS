//
//  WTMGlyphTemplate.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/15/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTMGlyphUtilities.h"

@interface WTMGlyphTemplate : NSObject {
    NSString *name;
    NSMutableArray *points;
    NSMutableArray *normalizedPoints;
    CGPoint startUnitVector;
    FloatArrayContainer vector;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) NSMutableArray *normalizedPoints;
@property (nonatomic, assign) FloatArrayContainer vector;

- (id)initWithName:(NSString *)_name points:(NSArray *)_points;
- (void)normalize;

@end
