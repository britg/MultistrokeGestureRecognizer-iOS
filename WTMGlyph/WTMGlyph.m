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
    [strokeOrders release];
    [permutedStrokeOrders release];
    [templates release];
    
    [super dealloc];
}

- (id)init {
    if ((self = [super init])) {
        self.strokes = [NSMutableArray array];
        strokeOrders = [NSMutableArray array];
        permutedStrokeOrders = [NSMutableArray array];
    }
    return self;
}

- (id)initWithName:(NSString *)_name strokes:(NSMutableArray *)_strokes {
    [self init];
    self.name = _name;
    [self createTemplates];
    return self;
}

- (id)initWithName:(NSString *)_name JSONData:(NSData *)jsonData {
    [self init];
    self.name = _name;
    [self createTemplatesFromJSONData:jsonData];
    return self;
}

#pragma mark - Templates

// Calculate all permutations of unistrokes from the points
- (void)createTemplates {
    // permute over all possible directions (heapPermute)
    [self permuteStrokeOrders:[strokeOrders count]];
    
    DebugLog(@"Permuted stroke orders %@", permutedStrokeOrders);
    // create WTMGlyphTemplates from all unistrokes
    
}

- (void)createTemplatesFromJSONData:(NSData *)jsonData {
    NSError *error = nil;
	NSArray *arr = [[CJSONDeserializer deserializer] deserializeAsArray:jsonData
                                                                  error:&error];
	DebugLog(@"json data %@", arr);
    int i = 0;
    for (NSArray *strokePoints in arr) {
        WTMGlyphStroke *stroke = [[WTMGlyphStroke alloc] init];
		for (NSArray *pointArray in strokePoints) {
            [stroke addPoint:CGPointMake([[pointArray objectAtIndex:0] floatValue], [[pointArray objectAtIndex:1] floatValue])];
		}
        DebugLog(@"Adding stroke to initial strokes %@", [stroke points]);
        [self.strokes addObject:stroke];
        [strokeOrders addObject:[NSNumber numberWithInt:i]];
        i++;
	}
    
    DebugLog(@"Strokes %@", self.strokes);
    DebugLog(@"Initial stroke orders %@", strokeOrders);
	
    [self createTemplates];
}

// Do the permutations of all the unistrokes
- (void)permuteStrokeOrders:(int)count {
    if (count == 1) {
        [permutedStrokeOrders addObject:[strokeOrders copy]];
    } else {
        for (int i = 0; i < count; i++) {
            [self permuteStrokeOrders:(count-1)];
            
            int last = [[strokeOrders objectAtIndex:(count - 1)] intValue];
            if (count % 2 == 1) {
                int first = [[strokeOrders objectAtIndex:0] intValue];
                [strokeOrders replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:last]];
                [strokeOrders replaceObjectAtIndex:(count-1) withObject:[NSNumber numberWithInt:first]];
            } else {   
                int next = [[strokeOrders objectAtIndex:i] intValue];
                [strokeOrders replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:last]];
                [strokeOrders replaceObjectAtIndex:(count-1) withObject:[NSNumber numberWithInt:next]];
            }
        }
    }
}

#pragma mark - On-the-fly creation

- (void)addPoint:(CGPoint)point {
    
}

- (void)startStroke {
    
}

- (void)endStroke {
    
}

@end
