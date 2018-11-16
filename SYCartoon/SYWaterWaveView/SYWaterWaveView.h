//
//  SYWaterWaveView.h
//  SY_Animation
//
//  Created by FaceBook on 2018/10/18.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYHexColor(hexValue) IBHexColorA(hexValue, 1.0)
#define SYHexColorA(hexValue, a) [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:a]

@interface SYWaterWaveView : UIView

@property (nonatomic, assign) CGFloat waveAmplitude;
@property (nonatomic, assign) CGFloat waveCycle;

@property (nonatomic, assign) CGFloat waveSpeed;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat wavePointY;

@property (nonatomic, assign) CGFloat waveOffsetX;
@property (nonatomic, strong) UIColor *waveColor;

- (instancetype)initWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end
