//
//  TMGMenuViewController.m
//  TwentyMinuteGenealogist
//
//  Created by Casey Moncur on 6/17/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#import "TMGMenuViewController.h"
#import "AGMedallionView.h"
#import "TMGSettings.h"

@interface TMGMenuViewController ()
@property (weak, nonatomic) IBOutlet AGMedallionView *userImage;
@property (weak, nonatomic) TMGSettings* settings;
@property (weak, nonatomic) IBOutlet UISwitch *birth;
@property (weak, nonatomic) IBOutlet UISwitch *death;
@property (weak, nonatomic) IBOutlet UISwitch *marriage;
@property (weak, nonatomic) IBOutlet UISwitch *ldsOrdinances;
@property (weak, nonatomic) IBOutlet UISwitch *basicInfo;
@end

@implementation TMGMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.settings = [TMGSettings instance];
    self.userImage.borderColor = [UIColor colorWithWhite:0.96f alpha:1.0f];
    self.userImage.borderWidth = 3;
	self.userImage.image = [UIImage imageNamed:@"profile"];
        
    self.birth.on = self.settings.showBirth;
    self.death.on = self.settings.showDeath;
    self.marriage.on = self.settings.showMarriage;
    self.ldsOrdinances.on = self.settings.showLdsOrdinances;
    self.basicInfo.on = self.settings.showBasicInfo;
}

- (IBAction)basicInfoChanged:(id)sender {
    self.settings.showBasicInfo = self.basicInfo.isOn;
}

- (IBAction)birthChanged:(id)sender {
    self.settings.showBirth = self.birth.isOn;
}

- (IBAction)deathChanged:(id)sender {
    self.settings.showDeath = self.death.isOn;
}

- (IBAction)marriageChanged:(id)sender {
    self.settings.showMarriage = self.marriage.isOn;
}

- (IBAction)ldsOrdinancesChanged:(id)sender {
    self.settings.showLdsOrdinances = self.ldsOrdinances.isOn;
}


@end
