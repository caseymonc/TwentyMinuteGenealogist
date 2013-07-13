//
//  TMGSettings.m
//  TwentyMinuteGenealogist
//
//  Created by Casey Moncur on 6/18/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#import "TMGSettings.h"

@interface TMGSettings()
@property (strong, nonatomic) NSMutableDictionary* settings;
@end

@implementation TMGSettings
static TMGSettings *instance;

+ (TMGSettings*) instance{
    if (!instance) {
        instance = [TMGSettings new];
        [instance loadSettings];
    }
    
    return instance;
}

- (void) loadSettings {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([paths count] > 0) {
        NSString  *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"settings.out"];
        self.settings = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    }
    
    if (!self.settings) {
        self.settings = [NSMutableDictionary new];
        self.settings[@"showBasicInfo"] = [NSNumber numberWithBool:YES];
        self.settings[@"showBirth"] = [NSNumber numberWithBool:YES];
        self.settings[@"showDeath"] = [NSNumber numberWithBool:YES];
        self.settings[@"showMarriage"] = [NSNumber numberWithBool:YES];
        self.settings[@"showLdsOrdinances"] = [NSNumber numberWithBool:NO];
    }
    
    NSNumber* showBasicInfo = self.settings[@"showBasicInfo"];
    self.showBasicInfo = [showBasicInfo boolValue];
    
    NSNumber* showBirth = self.settings[@"showBirth"];
    self.showBirth = [showBirth boolValue];
    
    NSNumber* showDeath = self.settings[@"showDeath"];
    self.showDeath = [showDeath boolValue];
    
    NSNumber* showMarriage = self.settings[@"showMarriage"];
    self.showMarriage = [showMarriage boolValue];
    
    NSNumber* showLdsOrdinances = self.settings[@"showLdsOrdinances"];
    self.showLdsOrdinances = [showLdsOrdinances boolValue];
}

- (void) saveSettings {
    if (!self.settings) {
        return;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([paths count] > 0) {
        NSString  *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"settings.out"];
        [self.settings writeToFile:dictPath atomically:YES];
    }
}


// Property Methods are saved to a dictionary for persistance

- (void) setShowBasicInfo: (BOOL) showBasicInfo{
    _showBasicInfo = showBasicInfo;
    self.settings[@"showBasicInfo"] = [NSNumber numberWithBool:showBasicInfo];
    [self saveSettings];
}

- (void) setShowBirth:(BOOL)showBirth {
    _showBirth = showBirth;
    self.settings[@"showBirth"] = [NSNumber numberWithBool:showBirth];
    [self saveSettings];
}

- (void) setShowDeath:(BOOL)showDeath {
    _showDeath = showDeath;
    self.settings[@"showDeath"] = [NSNumber numberWithBool:showDeath];
    [self saveSettings];
}

- (void) setShowMarriage:(BOOL)showMarriage {
    _showMarriage = showMarriage;
    self.settings[@"showMarriage"] = [NSNumber numberWithBool:showMarriage];
    [self saveSettings];
}

- (void) setShowLdsOrdinances:(BOOL)showLdsOrdinances {
    _showLdsOrdinances = showLdsOrdinances;
    self.settings[@"showLdsOrdinances"] = [NSNumber numberWithBool:showLdsOrdinances];
    [self saveSettings];
}

@end
