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
#import "WTMGlyphStroke.h"


@interface WTMGlyphDetector : NSObject {
    
    id<WTMGlyphDelegate> delegate;
    
    NSMutableArray *points;
    NSMutableArray *strokes;
    WTMGlyphStroke *activeStroke;
    
    NSInteger timeoutSeconds;
    NSTimeInterval lastPointTime;
    
}

@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) WTMGlyphStroke *activeStroke;
@property (nonatomic) NSInteger timeoutSeconds;

+ (id)detector;
- (id)init;

- (void)addPoint:(CGPoint)point;

- (void)strokeDidBegin;
- (void)strokeDidEnd;

- (void)resetIfTimeout;
- (void)reset;

@end
