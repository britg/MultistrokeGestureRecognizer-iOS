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


@interface WTMGlyphDetector : NSObject {
    
    id<WTMGlyphDelegate> delegate;
    
    NSMutableArray *points;
    NSMutableArray *glyphs;
    
    NSInteger timeoutSeconds;
    NSTimeInterval lastPointTime;
    
}

@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) NSMutableArray *glyphs;
@property (nonatomic) NSInteger timeoutSeconds;

+ (id)detector;
- (id)init;
- (id)initWithGlyphs:(NSArray *)_glyphs;

- (void)addGlyph:(WTMGlyph *)glyph;
- (void)addGlyphFromJSON:(NSData *)jsonData name:(NSString *)name;
- (void)removeGlyphByName:(NSString *)name;

- (void)addPoint:(CGPoint)point;
- (void)detectGlyph;
- (NSArray *)resample:(NSArray *)_points;
- (NSArray *)translate:(NSArray *)_points;
- (NSArray *)vectorize:(NSArray *)_points;

- (void)detectIfTimedOut;
- (void)resetIfTimedOut;
- (void)reset;
- (BOOL)hasTimedOut;

@end
