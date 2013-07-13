//
//  TMGFanLocation.m
//  TwentyMinuteGenealogist
//
//  Created by Casey Moncur on 6/23/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#import "TMGFanLocation.h"

@implementation TMGFanLocation

- (id)initWithLocation:(int)location generation:(int)generation {
    if (self = [super init]) {
        self.location = location;
        self.generation = generation;
    }
    
    return self;
}

- (BOOL) isEqual:(id)object {
    if ([object isKindOfClass:[TMGFanLocation class]]) {
        TMGFanLocation* location = object;
        return self.location == location.location && self.generation == location.generation;
    }
    
    return NO;
}

@end
