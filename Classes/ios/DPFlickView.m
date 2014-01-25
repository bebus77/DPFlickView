//
//  DPFlickView.m
//  flickview
//
//  Created by David Harver Pollak on 16/01/14.
//  Copyright (c) 2014 David Harver Pollak. All rights reserved.
//

#import "DPFlickView.h"

@implementation DPFlickView

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
const int kRotationRadius = 180.0;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Default rotation angle defined at 10 degrees
        self.rotationAngle = 10;
        
        // Setup initial center position to restore it afterwards
        initialCenterPosition = self.center;
        
        // Initial alpha value for the subviews' opacity
        _alphaValue = 1.0;
        
        // Default initialization of the left fading subviews
        self.leftFadingSubviews = @[];
        
        // Default initialization of the right fading subviews
        self.rightFadingSubviews = @[];
        
        // Default block triggered when the view is flicked to left
        self.leftAction = ^{};
        
        // Default block triggered when the view is flicked to right
        self.rightAction = ^{};
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Get the initial touch relative to the view itself
    initialTouchPoint = [[touches anyObject] locationInView:self];
    
    // Get the initial touch relative to the view's superview
    initialScreenPoint = [[touches anyObject] locationInView:self.superview];
    
    // Set the rotation direction based on the y value of the initial touch
    rotationDirection = -1;
    if (initialTouchPoint.y < self.bounds.size.height / 2) {
        rotationDirection = 1;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // Get the latest touch
    CGPoint movedTouchPoint = [[touches anyObject] locationInView:self.superview];
    
    // Set the new view's center based on the moved touch
    self.center = CGPointMake(movedTouchPoint.x - initialTouchPoint.x + self.bounds.size.width / 2,
                              movedTouchPoint.y - initialTouchPoint.y + self.bounds.size.height / 2);
    
    // Incremental angle setup
    double angle = (self.center.x - kRotationRadius) / kRotationRadius * DEGREES_TO_RADIANS(self.rotationAngle);
    
    // Incremental opacity alpha value
    _alphaValue = fabsf((self.center.x - kRotationRadius) / kRotationRadius);
    
    // Check the view's direction
    if (movedTouchPoint.x <= initialScreenPoint.x) {
        [self fadeSubviews:self.leftFadingSubviews];
    } else {
        [self fadeSubviews:self.rightFadingSubviews];
    }
    
    // Apply the rotation transformation to the view
    [self setTransform:CGAffineTransformMakeRotation(rotationDirection * angle)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // Restore initial position
    CGPoint destinationCenter = initialCenterPosition;
    
    // Check if one of the to blocks should be triggered
    if (self.center.x < self.superview.center.x / 2) {
        destinationCenter = CGPointMake(self.superview.bounds.origin.x - self.bounds.size.width, self.center.y);
        self.leftAction();
    } else if (self.center.x > self.superview.center.x * 3 / 2) {
        destinationCenter = CGPointMake(self.superview.bounds.size.width + self.bounds.size.width, self.center.y);
        self.rightAction();
    }
    
    // Animate, move and restore the opacity alpha value
    [UIView animateWithDuration:0.2 animations:^{
        self.center = destinationCenter;
        [self setTransform:CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0))];
        
        _alphaValue = 0.0;
        [self fadeSubviews:self.leftFadingSubviews];
        [self fadeSubviews:self.rightFadingSubviews];
    }];
}

- (void)fadeSubviews:(NSArray *)sViews {
    // Set the opacity alpha value for each view in the given array
    for (UIView *sView in sViews) {
        // Check if the current element in the array is a UIView and subview of self
        if ([sView isKindOfClass:[UIView class]] && [sView isDescendantOfView:self]) {
            sView.alpha = self.alphaValue;
        }
    }
}

@end
