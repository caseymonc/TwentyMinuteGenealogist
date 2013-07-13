//
//  TMGSlideViewController.m
//  TwentyMinuteGenealogist
//
//  Created by Casey Moncur on 6/17/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#import "TMGSlideViewController.h"
#import "TMGMainViewController.h"
#import "TMGMenuViewController.h"

@interface TMGSlideViewController ()
@property (strong, nonatomic) UIStoryboard* storyboard;
@property (weak, nonatomic) TMGMainViewController* main;
@property (weak, nonatomic) TMGMenuViewController* menu;
@end

@implementation TMGSlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _initialize];
    }
    return self;
}

- (void)_initialize {
    [self view];
    //__weak typeof(self) weakSelf = self;
    
    
    [UIStoryboard storyboardWithName:@"TMGStoryboard" bundle:nil];
    
    self.menu = [[UIStoryboard storyboardWithName:@"TMGMenuStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"TMGMenuViewController"];
    self.main = [[UIStoryboard storyboardWithName:@"TMGStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"TMGMainViewController"];

    self.masterViewController = self.menu;
    self.delegate = self;
    
    //[self setAppearanceType:MSNavigationPaneAppearanceTypeParallax];
    [self setPaneViewController:self.main animated:NO completion:nil];
}

- (void)navigationPaneViewController:(MSNavigationPaneViewController *)navigationPaneViewController willAnimateToPane:(UIViewController *)paneViewController {
}

- (void)navigationPaneViewController:(MSNavigationPaneViewController *)navigationPaneViewController didAnimateToPane:(UIViewController *)paneViewController {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
