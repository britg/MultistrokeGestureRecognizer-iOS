//
//  WTMGlyphDetector.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WTMGlyph.h"
#import "WTMGlyphDelegate.h"


@interface WTMGlyphDetector : NSObject {
    
    id<WTMGlyphDelegate> delegate;
    NSMutableArray *points;
    
}

@property (nonatomic, retain) NSMutableArray *points;

+ (id)detector;

- (void)addPoint:(CGPoint)point;

@end
