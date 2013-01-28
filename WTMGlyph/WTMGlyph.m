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

        strokeOrders = [[NSMutableArray alloc] init];
        permutedStrokeOrders = [[NSMutableArray alloc] init];
        unistrokes = [[NSMutableArray alloc] init];
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
    for (int i = 0; i < [unistrokes count]; i++) {
        WTMGlyphTemplate *newTemplate = [[WTMGlyphTemplate alloc] initWithName:self.name 
                                                                        points:[unistrokes objectAtIndex:i]];
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

- (void)permuteStrokeOrders:(int)count {
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
    NSArray *points;
    NSMutableArray *unistroke;
    NSMutableArray *strokeOrder;
    WTMGlyphStroke *stroke;
    NSMutableArray *copyOfStrokePoints;
    
    for (int r = 0; r < [permutedStrokeOrders count]; r++) {
        
        strokeOrder = [permutedStrokeOrders objectAtIndex:r];
        
        for (int b = 0; b < pow(2, [strokeOrder count]); b++) {
            
            unistroke = [NSMutableArray array];
            
            for (int i = 0; i < [strokeOrders count]; i++) {
                
                int strokeIndex = [[strokeOrder objectAtIndex:i] intValue];
                stroke = [self.strokes objectAtIndex:strokeIndex];
                copyOfStrokePoints = [NSMutableArray arrayWithArray: [[stroke points] copy]];
                
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
    
    for (int i = 0; i < [self.templates count]; i++) {
        WTMGlyphTemplate *template = [self.templates objectAtIndex:i];
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
