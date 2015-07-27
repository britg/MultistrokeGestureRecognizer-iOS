//
//  WTMGlyph.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/1/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyph.h"
#import "WTMGlyphStroke.h"
#import "WTMGlyphTemplate.h"
#import "WTMGlyphUtilities.h"
#import "CJSONDeserializer.h"

@implementation WTMGlyph

@synthesize name;
@synthesize strokes;
@synthesize templates;

#pragma mark - Lifecycle

- (id)init {
    self = [super init];
    if (self) {
        self.strokes = [NSMutableArray array];
        self.templates = [NSMutableArray array];

        strokeOrders = [NSMutableArray array];
        permutedStrokeOrders = [NSMutableArray array];
        unistrokes = [NSMutableArray array];
    }
    return self;
}

- (id)initWithName:(NSString *)_name strokes:(NSMutableArray *)_strokes {
    if (!(self = [self init])) return nil;
    self.name = _name;
    [self createTemplates];
    return self;
}

- (id)initWithName:(NSString *)_name JSONData:(NSData *)jsonData {
    if (!(self = [self init])) return nil;
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
    [self createUnistrokes];
    DebugLog(@"Unistrokes %@", unistrokes);
    
    // actually create the templates from unistrokes
    for (NSArray *unistroke in unistrokes) {
        WTMGlyphTemplate *newTemplate = [[WTMGlyphTemplate alloc] initWithName:self.name
                                                                        points:unistroke];
        [self.templates addObject:newTemplate];
    }
    DebugLog(@"Templates %@", self.templates);
    DebugLog(@"Template count %i", [self.templates count]);
}

- (void)createTemplatesFromJSONData:(NSData *)jsonData {
    NSError *error = nil;
	NSArray *arr = [[CJSONDeserializer deserializer] deserializeAsArray:jsonData error:&error];
	DebugLog(@"json data %@", arr);
    int i = 0;
    for (NSArray *strokePoints in arr) {
        WTMGlyphStroke *stroke = [[WTMGlyphStroke alloc] init];
		for (NSArray *pointArray in strokePoints)
            [stroke addPoint:CGPointMake([[pointArray objectAtIndex:0] floatValue], [[pointArray objectAtIndex:1] floatValue])];
		
        [self.strokes addObject:stroke];
        [strokeOrders addObject:[NSNumber numberWithInt:i]];
        i++;
	}
    
   DebugLog(@"Strokes %@", self.strokes);
    DebugLog(@"Initial stroke orders %@", strokeOrders);
	
    [self createTemplates];
}

- (void)permuteStrokeOrders:(NSUInteger)count {
    if (count == 1) {
        [permutedStrokeOrders addObject: [strokeOrders copy]];
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

// Create a unistroke for each stroke order permutation
- (void)createUnistrokes {
    for (NSMutableArray *strokeOrder in permutedStrokeOrders) {

        for (int b = 0; b < pow(2, [strokeOrder count]); b++) {
            
            NSMutableArray *unistroke = [NSMutableArray array];
            
            for (int i = 0; i < [strokeOrders count]; i++) {
                
                int strokeIndex = [[strokeOrder objectAtIndex:i] intValue];
                WTMGlyphStroke *stroke = [self.strokes objectAtIndex:strokeIndex];
                NSMutableArray *copyOfStrokePoints = [NSMutableArray arrayWithArray: [[stroke points] copy]];

                NSArray *points;
                if (((b >> i) & 1) == 1) {
                    points = [[copyOfStrokePoints reverseObjectEnumerator] allObjects];
                } else {
                    points = copyOfStrokePoints;
                }
                
                for (int p = 0; p < [points count]; p++) {
                    [unistroke addObject:[points objectAtIndex:p]];
                }
                
            }
            
            [unistrokes addObject:unistroke];
        }
    }
}

#pragma mark - Recognition

- (float)recognize:(WTMGlyphTemplate *)input {

    float lowestDistance = FLT_MAX;
    float distance = FLT_MAX;
    
    for (WTMGlyphTemplate *template in self.templates) {
        distance = OptimalCosineDistance(template.vector, input.vector);
        
        if (distance < lowestDistance) {
            lowestDistance = distance;
        }
    }
    
    return lowestDistance;
}

#pragma mark - On-the-fly creation

- (void)addPoint:(CGPoint)point {
    
}

- (void)startStroke {
    
}

- (void)endStroke {
    
}

@end
