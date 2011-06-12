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
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) NSMutableArray *normalizedPoints;

- (id)initWithName:(NSString *)_name points:(NSArray *)_points;
- (void)normalize;

@end
