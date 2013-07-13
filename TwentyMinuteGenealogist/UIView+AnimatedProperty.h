//
//  UIView+AnimatedProperty.h
//  AnimatedProperty
//
//  Created by Martin Kiss on 3.2.13.
//  Copyright (c) 2013 iMartin Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class ANPAnimation; // Declared below.



@interface UIView (AnimatedProperty)

+ (ANPAnimation *)currentAnimation;

+ (void)anp_new_animateWithDuration:(NSTimeInterval)duration
                         animations:(void (^)(void))animations;

+ (void)anp_new_animateWithDuration:(NSTimeInterval)duration
                         animations:(void (^)(void))animations
                         completion:(void (^)(BOOL))completion;

+ (void)anp_new_animateWithDuration:(NSTimeInterval)duration
                              delay:(NSTimeInterval)delay
                            options:(UIViewAnimationOptions)options
                         animations:(void (^)(void))animations
                         completion:(void (^)(BOOL))completion;

@end



@interface ANPAnimation : NSObject

// Atrributes of the animation.
@property (nonatomic, readonly, assign) NSTimeInterval delay;
@property (nonatomic, readonly, assign) NSTimeInterval duration;
@property (nonatomic, readonly, assign) UIViewAnimationOptions options;

// Convenience accessors for animation options
@property (nonatomic, readonly, strong) CAMediaTimingFunction *timingFunction;
@property (nonatomic, readonly, assign) BOOL layoutSubviews;
@property (nonatomic, readonly, assign) BOOL allowUserInteraction;
@property (nonatomic, readonly, assign) BOOL beginFromCurrentState;
@property (nonatomic, readonly, assign) BOOL repeat;
@property (nonatomic, readonly, assign) BOOL autoreverse;
@property (nonatomic, readonly, assign) BOOL overrideInheritedDuration;
@property (nonatomic, readonly, assign) BOOL overrideInheritedCurve;
@property (nonatomic, readonly, assign) BOOL allowAnimatedContent;

// Used internally to create animation representation.
- (id)initWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animationOptions:(UIViewAnimationOptions)options;

// Returns pre-set animation with duration, delay, keypath, value and fill mode. You can make additional changes and add the layer yourself.
- (CABasicAnimation *)basicAnimationForKeypath:(NSString *)keypath toValue:(id)toValue;

// Adds animation returned from above method to given layer
- (void)addBasicAnimationToLayer:(CALayer *)layer keypath:(NSString *)keypath toValue:(id)toValue;

@end