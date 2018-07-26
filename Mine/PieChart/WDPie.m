//
//  WDPie.m
//  Mine
//
//  Created by Facebook on 2018/7/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WDPie.h"

@implementation WDPie

+ (instancetype)pieWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color duration:(CFTimeInterval)duration piePatternType:(kPiePatternType)piePatternType isAnimated:(BOOL)isAnimated{
    return [[WDPie alloc] initWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:startAngle endAngle:endAngle color:color duration:duration piePatternType:piePatternType isAnimated:isAnimated];
}

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color duration:(CFTimeInterval)duration piePatternType:(kPiePatternType)piePatternType isAnimated:(BOOL)isAnimated{
    self = [super init];
    if (self) {
        self.fillColor = nil;
        self.strokeColor = color.CGColor;
        self.path = [self bezierWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle color:color].CGPath;
        
        if (isAnimated) {
            CABasicAnimation * animation = [self animationWithDuration:duration];
            [self addAnimation:animation forKey:nil];
        }
    }
    return self;
}

- (UIBezierPath *)bezierWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color{
    UIBezierPath * bezier = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    return bezier;
}

- (CABasicAnimation *)animationWithDuration:(CFTimeInterval)duration{
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration = duration;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = @(0.f);
    fillAnimation.toValue = @(1.f);
    
    return fillAnimation;
}

- (void)setIsShadow:(BOOL)isShadow{
    _isShadow = isShadow;
    if (_isShadow) {
        self.shadowOpacity = 1.f;
        self.shadowColor = [UIColor darkGrayColor].CGColor;
        self.shadowOffset = CGSizeMake(2, 2);
    }
}

@end





@implementation WDOpaquePie

+ (instancetype)layerWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise{
    return [[WDOpaquePie alloc] initWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
}

- (instancetype)initWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise{
    self = [super init];
    if (self) {
        self.fillColor = nil;
        self.opacity = 1.0f;
        self.path = [self translucencePathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise].CGPath;
    }
    return self;
}

- (UIBezierPath *)translucencePathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise{
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    return bezierPath;
}

@end



