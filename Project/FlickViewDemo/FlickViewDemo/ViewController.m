//
//  ViewController.m
//  FlickViewDemo
//
//  Created by David Harver Pollak on 25/01/14.
//  Copyright (c) 2014 David Harver Pollak. All rights reserved.
//

#import "ViewController.h"
#import <DPFlickView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DPFlickView *flickView = [[DPFlickView alloc] initWithFrame:CGRectMake(70, 150, 180, 180)];
    flickView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:flickView];
    
    flickView.leftAction = ^{ NSLog(@"LEFT ACTION");};
    flickView.rightAction = ^{ NSLog(@"RIGHT ACTION");};
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 15)];
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.text = @"RIGHT";
    rightLabel.alpha = 0.0;
    [flickView addSubview:rightLabel];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 50, 15)];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.text = @"LEFT";
    leftLabel.alpha = 0.0;
    [flickView addSubview:leftLabel];
    
    flickView.leftFadingSubviews = @[leftLabel];
    flickView.rightFadingSubviews = @[rightLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
