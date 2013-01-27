//
//  WTMGlyphDelegate.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WTMGlyph.h"

@protocol WTMGlyphDelegate <NSObject>

@optional
- (void)glyphDetected:(WTMGlyph *)glyph withScore:(float)score;
- (void)glyphResults:(NSArray *)results;

@end