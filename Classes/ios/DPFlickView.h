//
//  DPFlickView.h
//  flickview
//
//  Created by David Harver Pollak on 16/01/14.
//  Copyright (c) 2014 David Harver Pollak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPFlickView : UIView {
    CGPoint initialTouchPoint;
    CGPoint initialCenterPosition;
    CGPoint initialScreenPoint;
    int rotationDirection;
}

// Angle of rotation during the flick
@property (nonatomic) int rotationAngle;

// Incremental opacity value applied to selected subviews
@property (readonly) CGFloat alphaValue;

// Subviews to be faded while flicking left
@property (nonatomic, strong) NSArray *leftFadingSubviews;

// Subviews to be faded while flicking right
@property (nonatomic, strong) NSArray *rightFadingSubviews;

// Block to be triggered when the view is triggered left
@property (nonatomic, copy) void (^leftAction)(void);

// Block to be triggered when the view is triggered right
@property (nonatomic, copy) void (^rightAction)(void);

- (id)initWithFrame:(CGRect)frame;

@end
