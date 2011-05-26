//
//  WTMGlyphUtilities.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/15/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//

#import "WTMGlyphUtilities.h"

NSArray* Resample(NSArray *points, int num) {
    NSMutableArray *workingPoints = [NSMutableArray arrayWithArray:points];
    NSMutableArray *newPoints = [NSMutableArray arrayWithObject:[points objectAtIndex:0]];
    float I = PathLength(points) / (num -1);
    float D = 0.0;
    int i;
    NSValue *v1;
    NSValue *v2;
    CGPoint p1;
    CGPoint p2;
    CGPoint newPoint;
    NSValue *newVal;
    
    for ( i=1; i<workingPoints.count; i++ ) {
        v1 = [workingPoints objectAtIndex:(i-1)];
        v2 = [workingPoints objectAtIndex:i];
        p1 = [v1 CGPointValue];
        p2 = [v2 CGPointValue];
        float d = Distance(p1, p2);
        
        if ((D + d) >= I) {
            float x = p1.x + ((I-D) / d) * (p2.x - p1.x);
            float y = p1.y + ((I-D) / d) * (p2.y - p1.y);
            newPoint = CGPointMake(x, y);
            newVal = [NSValue valueWithCGPoint:newPoint];
            [newPoints addObject:newVal];
            workingPoints = Splice(workingPoints, newVal, i);
            D = 0.0;
        } else {
            D += d;
        }
        
    }
    
    // rounding error handling
    if ( newPoints.count == num - 1 ) {
        NSValue *finalValue = [points objectAtIndex:points.count-1];
        [newPoints addObject:finalValue];
    }
    
    return newPoints;
}

NSArray* Scale(NSArray *points, int resolution, float threshold) {
    NSArray *scaled;
    
    return scaled;
}

CGRect BoundingBox(NSArray *points) {
    float minX = FLT_MAX;
    float maxX = -FLT_MAX;
    float minY = FLT_MAX;
    float maxY = -FLT_MAX;
    
    NSEnumerator *eachPoint = [points objectEnumerator];
    NSValue *v;
    CGPoint pt;
    while ( (v = (NSValue *)[eachPoint nextObject]) ) {
        pt = [v CGPointValue];
        
        if( pt.x < minX )
            minX = pt.x;
        if( pt.y < minY )
            minY = pt.y;
        if( pt.x > maxX )
            maxX = pt.x;
        if( pt.y > maxY )
            maxY = pt.y;
    }
    
    return CGRectMake(minX, minY, (maxX-minX), (maxY-minY));
}

NSMutableArray* Splice(NSMutableArray *original, id newVal, int i) {
    NSArray *frontSlice = [original subarrayWithRange:NSMakeRange(0, i)];
    int len = original.count-i;
    NSArray *backSlice = [original subarrayWithRange:NSMakeRange(i, len)];
    
    NSMutableArray *spliced = [NSMutableArray arrayWithArray:frontSlice];
    [spliced addObject:newVal];
    [spliced addObjectsFromArray:backSlice];
    
    return spliced;
}

float PathLength(NSArray *points) {
    float d = 0.0;
    NSValue *v1;
    NSValue *v2;
    CGPoint p1;
    CGPoint p2;
    int i;
    
    for ( i=1; i<points.count; i++ ) {
        v1 = [points objectAtIndex:(i-1)];
        v2 = [points objectAtIndex:i];
        p1 = [v1 CGPointValue];
        p2 = [v2 CGPointValue];
        
        d += Distance(p1, p2);
    }
    return d;
}

float Distance(CGPoint point1, CGPoint point2) {
    int dX = point2.x - point1.x;
    int dY = point2.y - point1.y;
    float dist = sqrt( dX * dX + dY * dY );
    return dist;
}