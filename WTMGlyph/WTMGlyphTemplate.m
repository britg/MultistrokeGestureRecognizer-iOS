//
//  WTMGlyphTemplate.m
//  WTMGlyph
//
//  Created by Brit Gardner on 5/15/11.
//  Copyright 2011 Warrior Thief Mage Studios. All rights reserved.
//
//  A collection of points representing the unistroke of a
//  multistroke.

#import "WTMGlyphTemplate.h"
#import "WTMGlyphUtilities.h"
#import "WTMGlyphDefaults.h"

@implementation WTMGlyphTemplate

@synthesize name;
@synthesize points;
@synthesize normalizedPoints;
@synthesize vector;

- (void)dealloc
{
    free(vector.items);
}

- (id)initWithName:(NSString *)_name points:(NSArray *)_points {
    if ((self = [super init])) {
        self.name = _name;
        self.points = [NSMutableArray arrayWithArray:_points];
        [self normalize];
    }
    
    return self;
}

- (void)normalize {
    
    // Resample the points
    NSMutableArray *resampled = [NSMutableArray arrayWithArray:Resample(self.points, WTMGlyphResamplePointsCount)];
    DebugLog(@"Resampled points %@", resampled);
    
    // Calculate indicative angle (radians)
//    float radians = IndicativeAngle(resampled);
//    DebugLog(@"Indicative angle %f", radians);
    
    // Scale points to the desired resolution
    NSMutableArray *scaled = [NSMutableArray arrayWithArray:Scale(resampled, WTMGlyphResolution, WTMGlyph1DThreshold)];
    DebugLog(@"Scaled points %@", scaled);
    
    // Translate points to 0,0
    NSMutableArray *translated = [NSMutableArray arrayWithArray:TranslateToOrigin(scaled)];
    DebugLog(@"Translated points %@", translated);
    
    self.normalizedPoints = translated;
    
    // Calculate start unit vector
    startUnitVector = CalcStartUnitVector(translated, WTMGlyphStartAngleIndex);
    
    // Vectorize
    self.vector = Vectorize(self.normalizedPoints);
}



@end
