//
//  TMGSettings.h
//  TwentyMinuteGenealogist
//
//  Created by Casey Moncur on 6/18/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMGSettings : NSObject
@property (nonatomic) BOOL showBasicInfo;
@property (nonatomic) BOOL showBirth;
@property (nonatomic) BOOL showDeath;
@property (nonatomic) BOOL showMarriage;
@property (nonatomic) BOOL showLdsOrdinances;

+ (TMGSettings*) instance;

- (void) loadSettings;
- (void) saveSettings;

@end
