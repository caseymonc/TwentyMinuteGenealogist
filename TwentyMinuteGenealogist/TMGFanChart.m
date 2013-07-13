//
//  TMGFanChart.m
//  FanChart
//
//  Created by Casey Moncur on 6/20/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#include <math.h>
#import "TMGFanChart.h"
#import "TMGFanLocation.h"

#define GENERATIONS 5
#define WIDTH 30


@interface TMGFanChart()
@property (nonatomic) CGFloat itemDistanceFromCenter;
@property (nonatomic) CGFloat angleFromCenter;
@property (nonatomic) CGFloat totalAngle;
@property (nonatomic) CGPoint distanceFromCenter;
@property (strong, nonatomic) NSTimer* animationTimer;
@property (nonatomic) TMGFanLocation* touchedLocation;
@end

@implementation TMGFanChart

- (void)awakeFromNib {
    self.totalAngle = 360;
    self.angleFromCenter = 90;
    self.distanceFromCenter = CGPointMake(0, 0);
    self.fanPosition = Center;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGPoint center = CGPointMake(rect.size.width/2 + self.distanceFromCenter.x, rect.size.height/2 + self.distanceFromCenter.y);
    //center = [self radiansToScreenPosition:0 radius:self.itemDistanceFromCenter center:center];
    
    UIColor* color;
    if (self.delegate) {
        color = [self.delegate colorForLocation:0 inGeneration: 0];
    } else {
        color = [UIColor colorWithRed:0 green:0 blue:150 alpha:1.0f];
    }
    
    //Draw stroke and shadow
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 5.0f, [[UIColor colorWithWhite:0.0 alpha:1.0] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite:0.3f alpha:0.5f] CGColor]);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, WIDTH * GENERATIONS, self.angleFromCenter * M_PI / 180, (self.totalAngle + self.angleFromCenter) * M_PI / 180, NO);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    //Draw center circle
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, WIDTH - 1, self.angleFromCenter * M_PI / 180, (self.totalAngle + self.angleFromCenter) * M_PI / 180, NO);
    CGContextFillPath(context);
    
    //Draw click center circle
    if (self.touchedLocation != nil && self.touchedLocation.generation == 0 && self.touchedLocation.location == 0) {
        //Draw center circle
        CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite:0.0f alpha:0.3f] CGColor]);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, center.x, center.y);
        CGContextAddArc(context, center.x, center.y, WIDTH - 1, self.angleFromCenter * M_PI / 180, (self.totalAngle + self.angleFromCenter) * M_PI / 180, NO);
        CGContextFillPath(context);
    }
    
    for (int i = 1; i < GENERATIONS; i++) {
        [self drawGeneration:i rect:rect context:context];
    }
}

- (void) drawGeneration:(int)generation rect:(CGRect)rect context:(CGContextRef)context {
    int peopleInGeneration = powf(2, generation);
    float sectionSize = self.totalAngle / (float)peopleInGeneration;
    for (float i = 0; i < peopleInGeneration; i++) {
        UIColor* color;
        if (self.delegate) {
            color = [self.delegate colorForLocation:i inGeneration: generation];
        }else if ((int)i % 2 == 0) {
            color = [UIColor colorWithRed:0 green:50/255 blue:150/255 alpha:1.0f];
        }else{
            color = [UIColor colorWithRed:0 green:0 blue:150/255 alpha:1.0f];
        }
        
        CGFloat startAngle = sectionSize * i;
        CGFloat endAngle = (sectionSize * i) + sectionSize;
        
        startAngle += self.angleFromCenter;
        endAngle += self.angleFromCenter;
        
        CGPoint center = CGPointMake(rect.size.width/2 + self.distanceFromCenter.x, rect.size.height/2 + self.distanceFromCenter.y);
        center = [self radiansToScreenPosition:(startAngle + endAngle)/2 radius:self.itemDistanceFromCenter center:center];
        
        [self drawArc:context color:color width:WIDTH center:center startAngle:startAngle endAngle:endAngle radius:WIDTH * generation];
        
        if (self.touchedLocation != nil && self.touchedLocation.generation == generation && self.touchedLocation.location == i) {
            [self drawArc:context color:[UIColor colorWithWhite:0.0f alpha:0.3f] width:WIDTH center:center startAngle:startAngle endAngle:endAngle radius:WIDTH * generation];
        }
    }
}

- (void) drawArc:(CGContextRef)context color:(UIColor*)color width:(int)width center:(CGPoint)center startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle radius:(CGFloat)radius{
    startAngle = startAngle*M_PI/180;
    endAngle = endAngle*M_PI/180;

    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetLineWidth(context, 1);
    
    CGPathMoveToPoint(path, nil, center.x, center.y);
    CGPathAddArc(path, NULL, center.x, center.y, radius + width - 1, startAngle, endAngle, 0);
    CGPathCloseSubpath(path);
    
    CGPathMoveToPoint(path, nil, center.x, center.y);
    CGPathAddArc(path, NULL, center.x, center.y, radius, startAngle, endAngle, 0);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGContextEOFillPath(context);
    
    CGPathRelease(path);
}

- (CGPoint) radiansToScreenPosition:(CGFloat)angle radius:(CGFloat)radius center:(CGPoint)center{
    CGFloat x = center.x + radius * cos((angle * M_PI) / 180);
    CGFloat y = center.y + radius * sin((angle * M_PI) / 180);
    return CGPointMake(x, y);
}

- (void) animateToBottom:(void (^)(void))done {
    self.fanPosition = Animating;
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(animateTo180) userInfo:nil repeats:YES];
}

- (void) animateToCenter:(void (^)(void))done {
    self.fanPosition = Animating;
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(animateTo360) userInfo:nil repeats:YES];
}

- (void) animateTo180 {
    if (self.totalAngle <= 180) {
        self.totalAngle = 180;
    } else {
        self.totalAngle -= 2;
    }
    
    if (self.angleFromCenter >= 180) {
        self.angleFromCenter = 180;
    }else{
        self.angleFromCenter += 1;
    }
    
    if (self.distanceFromCenter.y >= self.frame.size.height/2) {
        self.distanceFromCenter = CGPointMake(self.distanceFromCenter.x, self.frame.size.height/2);
    }else{
        self.distanceFromCenter = CGPointMake(self.distanceFromCenter.x, self.distanceFromCenter.y + 2.6);
    }
    
    if (self.angleFromCenter == 180 && self.totalAngle == 180 && self.distanceFromCenter.y == self.frame.size.height/2) {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
        self.fanPosition = Bottom;
    }
    
    [self setNeedsDisplay];
}

- (void) animateTo360 {
    if (self.totalAngle >= 360) {
        self.totalAngle = 360;
    } else {
        self.totalAngle += 2;
    }
    
    if (self.angleFromCenter <= 90) {
        self.angleFromCenter = 90;
    }else{
        self.angleFromCenter -= 1;
    }
    
    if (self.distanceFromCenter.y <= 0) {
        self.distanceFromCenter = CGPointMake(self.distanceFromCenter.x, 0);
    }else{
        self.distanceFromCenter = CGPointMake(self.distanceFromCenter.x, self.distanceFromCenter.y - 2.6);
    }
    
    if (self.angleFromCenter == 90 && self.totalAngle == 360 && self.distanceFromCenter.y == 0) {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
        self.fanPosition = Center;
    }
    
    [self setNeedsDisplay];
}

- (void) reduceItemDistanceFromCenter {
    self.itemDistanceFromCenter -= 1;
    if (self.itemDistanceFromCenter < 0) {
        self.itemDistanceFromCenter = 0;
    }
    [self setNeedsDisplay];
    
    if (self.itemDistanceFromCenter <= 0) {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
}

- (TMGFanLocation*) locationInFan:(CGPoint) point {
    CGFloat distance = [self distanceFromCenter: point];
    int generation = distance / WIDTH;
    
    if (generation == 0) {
        return [[TMGFanLocation alloc] initWithLocation:0 generation:0];
    }
    
    int peopleInGeneration = powf(2, generation);
    CGFloat angleFromCenter = [self angleFromCenterWithPoint:point];
    CGFloat sectionSize = self.totalAngle / peopleInGeneration;
    int location = angleFromCenter / sectionSize;
    
    return [[TMGFanLocation alloc] initWithLocation:location generation:generation];
}

- (CGFloat) distanceFromCenter:(CGPoint) point {
    CGPoint center = CGPointMake(self.frame.size.width/2 + self.distanceFromCenter.x, self.frame.size.height/2 + self.distanceFromCenter.y);
    
    CGFloat diffX = center.x - point.x;
    CGFloat diffY = center.y - point.y;
    
    diffX = diffX * diffX;
    diffY = diffY * diffY;
    
    return sqrtf(diffX + diffY);
}

- (CGFloat) angleFromCenterWithPoint:(CGPoint) point {
    CGPoint center = CGPointMake(self.frame.size.width/2 + self.distanceFromCenter.x, self.frame.size.height/2 + self.distanceFromCenter.y);
    CGFloat radians = atan2f( center.y - point.y , center.x - point.x);
    CGFloat degrees = (radians * 180) / M_PI;
    
    degrees = degrees + self.angleFromCenter;
    
    while (degrees < 0) {
        degrees += self.totalAngle;
    }
    
    while (degrees > self.totalAngle) {
        degrees -= self.totalAngle;
    }
    
    return degrees;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.touchedLocation = [self locationInFan:point];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.touchedLocation = nil;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    TMGFanLocation* location = [self locationInFan:point];
    if ([location isEqual:self.touchedLocation] && self.delegate) {
        [self.delegate itemClicked:location.location inGeneration:location.generation];
    }
    
    self.touchedLocation = nil;
    [self setNeedsDisplay];
}

@end
