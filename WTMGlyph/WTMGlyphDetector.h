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
    NSMutableArray *templates;
    
    NSInteger timeoutSeconds;
    NSTimeInterval lastPointTime;
    
}

@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) NSMutableArray *templates;
@property (nonatomic) NSInteger timeoutSeconds;

+ (id)detector;
- (id)init;
- (id)initWithGlyphTemplates:(NSArray *)_templates;

- (void)addPoint:(CGPoint)point;
- (void)detectGlyph;
- (NSArray *)resample:(NSArray *)_points;
- (NSArray *)translate:(NSArray *)_points;
- (NSArray *)vectorize:(NSArray *)_points;

- (void)resetIfTimeout;
- (void)reset;

@end
