//
//  ZFMethod.h
//  ZFChartView
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFMethod : NSObject

+ (instancetype)shareInstance;

/**
 *  存储固定颜色
 *
 *  @param color 指定颜色
 *  @param array 传入valueArray
 *
 *  @return 返回存储UIColor的数组
 */
- (NSMutableArray *)cachedColor:(UIColor *)color array:(NSArray *)array;


/**
 *  获取数据源最大值，并赋值给y轴最大上限
 */
- (CGFloat)cachedMaxValue:(NSMutableArray *)array;

/**
 *  获取数据源最小值，并赋值给y轴显示的最小值
 */
- (CGFloat)cachedMinValue:(NSMutableArray *)array;

/**
 *  所有value是否都为0
 */
- (BOOL)isAllValuesZero:(NSMutableArray *)array;

@end
