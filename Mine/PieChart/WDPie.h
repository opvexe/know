//
//  WDPie.h
//  Mine
//
//  Created by Facebook on 2018/7/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum{
    kPieChartPatternTypeCirque = 0,   //圆环
    kPieChartPatternTypeCircle = 1    //整圆
}kPiePatternType;

@interface WDPie : CAShapeLayer

//是否带阴影效果
@property (nonatomic, assign) BOOL isShadow;

/**
 *
 @param center center description
 @param radius radius description
 @param startAngle startAngle description
 @param endAngle endAngle description
 @param color color description
 @param duration duration description
 @param piePatternType piePatternType description
 @param isAnimated isAnimated description
 @return return value description
 */
+ (instancetype)pieWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color duration:(CFTimeInterval)duration piePatternType:(kPiePatternType)piePatternType isAnimated:(BOOL)isAnimated;

@end


@interface  WDOpaquePie : CAShapeLayer

+ (instancetype)layerWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

@end
