//
//  WTMGlyphDetector.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTMGlyph.h"
#import "WTMGlyphDelegate.h"
#import "WTMDetectionResult.h"

@interface WTMGlyphDetector : NSObject {
    
    id<WTMGlyphDelegate> __unsafe_unretained delegate;
    
    NSMutableArray *points;
    NSMutableArray *glyphs;
    
    NSInteger timeoutSeconds;
    NSTimeInterval lastPointTime;
    
}

@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) NSMutableArray *glyphs;
@property (nonatomic, assign) NSInteger timeoutSeconds;

+ (id)detector;
+ (id)defaultDetector;
- (id)init;
- (id)initWithGlyphs:(NSArray *)_glyphs;
- (id)initWithDefaultGlyphs;

- (void)addGlyph:(WTMGlyph *)glyph;
- (void)addGlyphFromJSON:(NSData *)jsonData name:(NSString *)name;
- (void)removeGlyphByName:(NSString *)name;

- (void)addPoint:(CGPoint)point;
- (void)removeAllPoints;
- (void)removeAllGlyphs;

- (WTMDetectionResult*)detectGlyph;

- (NSArray *)resample:(NSArray *)_points;
- (NSArray *)translate:(NSArray *)_points;
- (NSArray *)vectorize:(NSArray *)_points;

- (void)detectIfTimedOut;
- (void)resetIfTimedOut;
- (void)reset;
- (BOOL)hasTimedOut;
- (BOOL)hasEnoughPoints;

@end
