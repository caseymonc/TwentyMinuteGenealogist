//
//  TMGMainViewController.m
//  TwentyMinuteGenealogist
//
//  Created by Casey Moncur on 6/17/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#import "TMGMainViewController.h"
#import "TMGSlideViewController.h"
#import "Macros.h"

@interface TMGMainViewController ()
@property (weak, nonatomic) IBOutlet TMGFanChart *fanChart;

@end

@implementation TMGMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fanChart.delegate = self;
	
}

- (IBAction)openMenu:(id)sender {
    [((TMGSlideViewController*)[self parentViewController]) setPaneState:MSNavigationPaneStateOpen animated:YES completion:nil];
}

- (UIColor *) colorForLocation:(int)location inGeneration:(int) generation {
    if (location % 2 == 0) {
        return [UIColor colorWithRed:153.f/255.f green:120.f/255.f blue:102.f/255.f alpha:1.0f];
    } else {
        return [UIColor colorWithRed:228.f/255.f green:236.f/255.f blue:240.f/255.f alpha:1.0f];
    }
}

- (void) itemClicked:(int)location inGeneration:(int)generation {
    if (self.fanChart.fanPosition == Center) {
        [self.fanChart animateToBottom:^{
            
        }];
    } else if(self.fanChart.fanPosition == Bottom) {
        [self.fanChart animateToCenter:^{
            
        }];
    }
    
}
@end
