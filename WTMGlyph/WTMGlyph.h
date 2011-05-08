//
//  WTMGlyph.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WTMGlyph : NSObject {
    NSString *name;
    NSArray *templatePoints;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *templatePoints;

- (id)init;
- (id)initWithName:(NSString *)_name templatePoints:(NSArray *)points;

@end
