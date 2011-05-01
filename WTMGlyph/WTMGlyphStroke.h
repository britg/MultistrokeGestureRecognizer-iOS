//
//  WTMGlyphStroke.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WTMGlyphStroke : NSObject {
    
    NSMutableArray *points;
    
}

@property (nonatomic, retain) NSMutableArray *points;

- (void)addPoint:(CGPoint)point;

@end
