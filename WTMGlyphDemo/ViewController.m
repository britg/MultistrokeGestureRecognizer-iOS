//
//  ViewController.m
//  WTMGlyphDemo
//
//  Created by Torin Nguyen on 5/7/12.
//  Copyright (c) 2012 torin.nguyen@2359media.com. All rights reserved.
//

#import "ViewController.h"
#import "WTMGlyphDetectorView.h"

@interface ViewController ()
@property (nonatomic, strong) WTMGlyphDetectorView *gestureDetectorView;
@property (nonatomic, strong) IBOutlet UILabel *lblStatus;
@end

@implementation ViewController
@synthesize gestureDetectorView;
@synthesize lblStatus;

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.gestureDetectorView = [[WTMGlyphDetectorView alloc] initWithFrame:self.view.bounds];
  self.gestureDetectorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.gestureDetectorView.delegate = self;
  [self.view addSubview:self.gestureDetectorView];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  NSString *glyphNames = [self.gestureDetectorView getGlyphNamesString];
  if ([glyphNames length] > 0) {
    NSString *statusText = [NSString stringWithFormat:@"Start drawing.\nLoaded with %@ templates.", [self.gestureDetectorView getGlyphNamesString]];
    self.lblStatus.text = statusText;
  }
}

- (void)viewDidUnload
{
  [self.gestureDetectorView removeFromSuperview];
  self.gestureDetectorView.delegate = nil;
  self.gestureDetectorView = nil;
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}


#pragma mark - Delegate

- (void)wtmGlyphDetectorView:(WTMGlyphDetectorView*)theView glyphDetected:(WTMGlyph *)glyph withScore:(float)score
{
  NSString *statusString = @"";
  
  NSString *glyphNames = [self.gestureDetectorView getGlyphNamesString];
  if ([glyphNames length] > 0)
    statusString = [statusString stringByAppendingFormat:@"Loaded with %@ templates.\n", glyphNames];
  
  statusString = [statusString stringByAppendingFormat:@"Last gesture detected: %@\nScore: %.1f", glyph.name, score];
  
  self.lblStatus.text = statusString;
}


@end
