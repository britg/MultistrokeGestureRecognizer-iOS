//
//  WTMGlyphTemplate.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/15/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WTMGlyphTemplate : NSObject {
    NSString *name;
    NSMutableArray *points;
    NSMutableArray *normalizedPoints;
    CGPoint startUnitVector;
    NSMutableArray *vector;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) NSMutableArray *normalizedPoints;
@property (nonatomic, strong) NSMutableArray *vector;

- (id)initWithName:(NSString *)_name points:(NSArray *)_points;
- (void)normalize;

@end
