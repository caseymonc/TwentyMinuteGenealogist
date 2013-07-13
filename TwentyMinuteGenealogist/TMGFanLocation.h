//
//  TMGFanLocation.h
//  TwentyMinuteGenealogist
//
//  Created by Casey Moncur on 6/23/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMGFanLocation : NSObject
@property (nonatomic) int location;
@property (nonatomic) int generation;

- (id)initWithLocation:(int)location generation:(int)generation;
@end
