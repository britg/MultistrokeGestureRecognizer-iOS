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
    if ( newPoints.count < num ) {
        NSValue *finalValue = [points objectAtIndex:points.count-1];
        
        for (int j = 0; j < (num-newPoints.count); j++) {
            [newPoints addObject:finalValue];
        }
    }
    
    return newPoints;
}

NSArray* Scale(NSArray *points, int resolution, float threshold) {
    NSMutableArray *scaled = [NSMutableArray array];
    
    CGRect bb = BoundingBox(points);
    
    BOOL is1D = MIN(bb.size.width / bb.size.height, bb.size.height / bb.size.width) <= threshold;
    
    for (int i = 0; i < [points count]; i++) {
        NSValue *v = [points objectAtIndex:i];
        CGPoint p = [v CGPointValue];
        float qx;
        float qy;
        float scale;
        
        if (is1D) {    
            scale = (resolution / MAX(bb.size.width, bb.size.height));
            qx = p.x * scale;
            qy = p.y * scale; 
        } else {
            qx = p.x * (resolution / bb.size.width);
            qy = p.y * (resolution / bb.size.height);
        }
        [scaled addObject:[NSValue valueWithCGPoint:CGPointMake(qx, qy)]];
    }
    
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

CGPoint Centroid(NSArray *points) {
    float x = 0.0;
    float y = 0.0;
    
    for (int i = 0; i < [points count]; i++) {
        NSValue *pointValue = [points objectAtIndex:i];
        CGPoint point = [pointValue CGPointValue];
        x += point.x;
        y += point.y;
    }
    
    x /= [points count];
    y /= [points count];
    
    return CGPointMake(x, y);
}

// Potential for error here: NDollar uses double!
float IndicativeAngle(NSArray *points) {
    CGPoint centroid = Centroid(points);
    CGPoint firstPoint = [[points objectAtIndex:0] CGPointValue];
    float x = (centroid.x - firstPoint.x);
    float y = (centroid.y - firstPoint.y);
    
    return atan2f(y, x);
}

NSArray* TranslateToOrigin(NSArray *points) {
    NSMutableArray *translated = [NSMutableArray array];
    CGPoint centroid = Centroid(points);
    float qx;
    float qy;
    
    for (int i = 0; i < [points count]; i++) {
        NSValue *pointValue = [points objectAtIndex:i];
        CGPoint point = [pointValue CGPointValue];
        qx = point.x - centroid.x;
        qy = point.y - centroid.y;
        [translated addObject:[NSValue valueWithCGPoint:CGPointMake(qx, qy)]];
    }
    
    return translated;
}

CGPoint CalcStartUnitVector(NSArray *points, int count) {
    CGPoint pointAtIndex = [[points objectAtIndex:count] CGPointValue];
    CGPoint firstPoint = [[points objectAtIndex:0] CGPointValue];
                          
    CGPoint v = CGPointMake(pointAtIndex.x - firstPoint.x, pointAtIndex.y - firstPoint.y);
    float len = sqrtf(v.x * v.x + v.y * v.y);
    
    return CGPointMake((v.x / len), (v.y / len));
}

FloatArrayContainer Vectorize(NSArray *points) {
    FloatArrayContainer v;
    v.itemCount = 0;
    v.allocatedCount = [points count] * 2 + 1;
    v.items = malloc(v.allocatedCount * sizeof(float));
    
    float cos = 1.0;
    float sin = 0.0;
    float sum = 0;
    CGPoint point;
    
    for (int i = 0; i < [points count]; i++) {
        point = [[points objectAtIndex:i] CGPointValue];
        float newX = point.x * cos - point.y * sin;
        float newY = point.y * cos + point.x * sin;
        v.items[i*2] = newX;
        v.items[i*2 + 1] = newY;
        v.itemCount += 2;
        sum += newX * newX + newY * newY;
    }
    
    float magnitude = sqrtf(sum);
    for (int i = 0; i < v.itemCount; i++)
        v.items[i] /= magnitude;
    
    return v;
}

float OptimalCosineDistance(FloatArrayContainer v1, FloatArrayContainer v2) {
    float a = 0.0;
    float b = 0.0;
    float angle;
    float score;
    
    int mincount = (v1.itemCount < v2.itemCount ? v1.itemCount : v2.itemCount);
    
    for (int ii = 0; ii < mincount; ii+=2) {
        a += v1.items[ii] * v2.items[ii] + v1.items[ii+1] * v2.items[ii+1];
        b += v1.items[ii] * v2.items[ii+1] - v1.items[ii+1] * v2.items[ii];
    }
    
    angle = atanf( b / a );
    score = acosf(a * cos(angle) + b * sin(angle));
    
    return score;
}
