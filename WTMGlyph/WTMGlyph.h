//
//  WTMGlyph.h
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTMGlyphStroke.h"
#import "WTMGlyphTemplate.h"

@interface WTMGlyph : NSObject {
    NSString *name;
    NSMutableArray *strokes;
    NSMutableArray *strokeOrders;
    NSMutableArray *permutedStrokeOrders;
    NSMutableArray *unistrokes;
    NSMutableArray *templates;
    
    WTMGlyphStroke *currentStroke;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *strokes;
@property (nonatomic, strong) NSMutableArray *templates;

- (id)init;
- (id)initWithName:(NSString *)_name strokes:(NSArray *)strokes;
- (id)initWithName:(NSString *)_name JSONData:(NSData *)jsonData;

- (void)createTemplates;
- (void)createTemplatesFromJSONData:(NSData *)jsonData;
- (void)permuteStrokeOrders:(int)count;
- (void)createUnistrokes;

- (float)recognize:(WTMGlyphTemplate *)_template;

- (void)addPoint:(CGPoint)point;
- (void)startStroke;
- (void)endStroke;

@end
