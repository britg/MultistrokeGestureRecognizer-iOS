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


@implementation WTMGlyphTemplate

@synthesize name;
@synthesize points;
@synthesize normalizedPoints;

- (void)dealloc {
    [name release];
    [points release];
    [normalizedPoints release];
    
    [super dealloc];
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
    self.normalizedPoints = [NSMutableArray arrayWithArray:Resample(self.points, WTMGlyphResamplePointsCount)];
    DebugLog(@"Resampled points %@", self.normalizedPoints);
    
    // Calculate indicative angle (radians)
    float radians = IndicativeAngle(self.normalizedPoints);
    DebugLog(@"Indicative angle %f", radians);
    
    // Scale points to the desired resolution
    self.normalizedPoints = [NSMutableArray arrayWithArray:Scale(self.normalizedPoints, WTMGlyphResolution, WTMGlyph1DThreshold)];
    DebugLog(@"Scaled points %@", self.normalizedPoints);
    
    // Translate points to 0,0
    
    // Calculate start unit vector
    
    // Vectorize
}



@end
