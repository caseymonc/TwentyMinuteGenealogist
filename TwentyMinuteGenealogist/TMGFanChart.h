//
//  TMGFanChart.h
//  FanChart
//
//  Created by Casey Moncur on 6/20/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

enum FanPosition{
    Center,
    Bottom,
    Animating
};

@protocol TMGFanChartDelegate <NSObject>
@required
- (UIColor *) colorForLocation:(int)location inGeneration:(int) generation;
- (void) itemClicked:(int)location inGeneration:(int)generation;
@end

@interface TMGFanChart : UIView
@property (weak, nonatomic) NSObject<TMGFanChartDelegate>* delegate;
@property (nonatomic) enum FanPosition fanPosition;
- (void) animateToBottom: (void (^)(void)) done;
- (void) animateToCenter:(void (^)(void))done;

@end
