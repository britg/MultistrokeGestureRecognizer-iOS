//
//  WTMDetectionResult.h
//  WTMGlyphDemo
//
//  Created by Ben Gotow on 1/27/13.
//  Copyright (c) 2013 torin.nguyen@2359media.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTMGlyph;

@interface WTMDetectionResult : NSObject

@property (nonatomic, retain) WTMGlyph * bestMatch;
@property (nonatomic, assign) float bestScore;
@property (nonatomic, retain) NSArray * allScores;
@property (nonatomic, assign) BOOL success;

@end
