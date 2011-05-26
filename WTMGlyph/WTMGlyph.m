//
//  WTMGlyph.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyph.h"
#import "WTMGlyphStroke.h"
#import "CJSONDeserializer.h"

@implementation WTMGlyph

@synthesize name;
@synthesize strokes;
@synthesize templates;

#pragma mark - Lifecycle

- (void)dealloc {
    [name release];
    [strokes release];
    [templates release];
    
    [super dealloc];
}

- (id)init {
    if ((self = [super init])) {

    }
    return self;
}

- (id)initWithName:(NSString *)_name strokes:(NSMutableArray *)_strokes {
    [self init];
    self.name = _name;
    self.strokes = _strokes;
    [self createTemplates];
    return self;
}

- (id)initWithName:(NSString *)_name JSONData:(NSData *)jsonData {
    [self init];
    self.name = _name;
    self.strokes = [NSMutableArray array];
    [self createTemplatesFromJSONData:jsonData];
    return self;
}

#pragma mark - Templates

// Calculate all permutations of unistrokes from the points
- (void)createTemplates {
    // permute over all possible directions (heapPermute)
    // create WTMGlyphTemplates from all unistrokes
    
}

- (void)createTemplatesFromJSONData:(NSData *)jsonData {
    NSError *error = nil;
	NSArray *arr = [[CJSONDeserializer deserializer] deserializeAsArray:jsonData
                                                                  error:&error];
	DebugLog(@"json data %@", arr);
    for (NSArray *strokePoints in arr) {
        WTMGlyphStroke *stroke = [[WTMGlyphStroke alloc] init];
		for (NSArray *pointArray in strokePoints) {
            [stroke addPoint:CGPointMake([[pointArray objectAtIndex:0] floatValue], [[pointArray objectAtIndex:1] floatValue])];
		}
        DebugLog(@"Adding stroke to initial strokes %@", [stroke points]);
        [self.strokes addObject:stroke];
	}
    
    DebugLog(@"Strokes %@", self.strokes);
	
    [self createTemplates];
}

// Do the permutations of all the unistrokes
- (void)heapPermute {
    
}

#pragma mark - On-the-fly creation

- (void)addPoint:(CGPoint)point {
    
}

- (void)startStroke {
    
}

- (void)endStroke {
    
}

@end
