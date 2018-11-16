//
//  ViewController.m
//  SYCartoon
//
//  Created by FaceBook on 2018/10/18.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ViewController.h"
#import "SYWaterWaveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    SYWaterWaveView *waterView = [[SYWaterWaveView alloc] initWithFrame:(CGRect){0, 0, CGRectGetWidth(self.view.bounds), 228} startColor:SYHexColorA(0xfbd49d, 0.7) endColor:SYHexColorA(0xff785c, 0.7)];
    [self.view addSubview:waterView];
    
    
    
}

- (void)animationSpread:(UIView*)view {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = 1.5;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    view.layer.transform = CATransform3DMakeScale(1, 1, 1);//当动画完成后，保持现状
    [view.layer addAnimation: scaleAnimation forKey:@"myScale"];
}

- (void)animationBack:(UIView*)view {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.duration = 1.5;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    view.layer.transform = CATransform3DMakeScale(0, 0, 1);
    [view.layer addAnimation: scaleAnimation forKey:@"myScale"];
}

@end
