//
//  WTMGlyphStroke.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    WTMGlyphStrokeTypeNone,
    WTMGlyphStrokeTypeNorth,
    WTMGlyphStrokeTypeNorthEast,
    WTMGlyphStrokeTypeEast,
    WTMGlyphStrokeTypeSouthEast,
    WTMGlyphStrokeTypeSouth,
    WTMGlyphStrokeTypeSouthWest,
    WTMGlyphStrokeTypeWest,
    WTMGlyphStrokeTypeNorthWest
} WTMGlyphStrokeType;

@interface WTMGlyphStroke : NSObject {
    
    NSMutableArray *points;
    
}

@property (nonatomic, retain) NSMutableArray *points;

- (void)addPoint:(CGPoint)point;
- (WTMGlyphStrokeType)analyzeStroke;

//+ (BOOL)isStrokeTypeNorth:(WTMGlyphStroke *)stroke;
//+ (BOOL)isStrokeTypeNorthEast:(WTMGlyphStroke *)stroke;
//+ (BOOL)isStrokeTypeEast:(WTMGlyphStroke *)stroke;
//+ (BOOL)isStrokeTypeSouthEast:(WTMGlyphStroke *)stroke;
//+ (BOOL)isStrokeTypeNorthEast:(WTMGlyphStroke *)stroke;

@end
