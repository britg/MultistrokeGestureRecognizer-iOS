//
//  WTMGlyphDetectorView.m
//  WTMGlyphDemo
//
//  Created by Torin Nguyen on 5/7/12.
//  Copyright (c) 2012 torin.nguyen@2359media.com. All rights reserved.
//

#import "WTMGlyphDetectorView.h"

@interface WTMGlyphDetectorView() <WTMGlyphDelegate>
@property (nonatomic, strong) WTMGlyphDetector *glyphDetector;
@property (nonatomic, strong) NSMutableArray *glyphNamesArray;
@end

@implementation WTMGlyphDetectorView
@synthesize delegate;
@synthesize glyphDetector;
@synthesize glyphNamesArray;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self initGestureDetector];
    }
    return self;
}

- (NSString *)getGlyphNamesString
{
  if (self.glyphNamesArray == nil || [self.glyphNamesArray count] <= 0)
    return @"";
  
  return [self.glyphNamesArray componentsJoinedByString: @", "];
}

- (void)initGestureDetector
{
  self.glyphDetector = [WTMGlyphDetector detector];
  self.glyphDetector.delegate = self;
  
  // Add initial glyph templates from JSON files
  // Rinse and repeat for each of the gestures you want to detect
  self.glyphNamesArray = [NSMutableArray arrayWithObjects:@"N", @"D", @"P", @"T", nil];
  for (NSString *glyphName in self.glyphNamesArray) {
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:glyphName ofType:@"json"]];
    [self.glyphDetector addGlyphFromJSON:jsonData name:glyphName];
  }

}



#pragma mark - WTMGlyphDelegate

- (void)glyphDetected:(WTMGlyph *)glyph withScore:(float)score
{
  //Simply forward it to my parent
  if ([self.delegate respondsToSelector:@selector(wtmGlyphDetectorView:glyphDetected:withScore:)])
    [self.delegate wtmGlyphDetectorView:self glyphDetected:glyph withScore:score];
}

- (void)glyphResults:(NSArray *)results
{
  //Raw results from the library?
  //Not sure what this delegate function is for, undocumented
}



#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:self];
  [self.glyphDetector addPoint:point];

  [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:self];
  [self.glyphDetector addPoint:point];
  
  [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:self];
  [self.glyphDetector addPoint:point];
  [self.glyphDetector detectGlyph];

  [super touchesEnded:touches withEvent:event]; 
}

@end
