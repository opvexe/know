//
//  WDPieChart.h
//  Mine
//
//  Created by Facebook on 2018/7/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDPie.h"
@class WDPieChart;

typedef enum{
    kPercentTypeDecimal = 0,   //保留2位小数形式(默认)
    kPercentTypeInteger = 1,   //取整数形式(四舍五入)
    kPercentTypeNone = 2       //None
}kPercentType;

@protocol WDPieChartDataSource <NSObject>
@required
- (NSArray *)valueArrayInPieChart:(WDPieChart *)pieChart;
- (NSArray *)colorArrayInPieChart:(WDPieChart *)pieChart;
@end

@protocol WDPieChartDelegate <NSObject>
@required
- (CGFloat)radiusForPieChart:(WDPieChart *)pieChart;
@optional
- (void)pieChart:(WDPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index;
- (CGFloat)allowToShowMinLimitPercent:(WDPieChart *)pieChart;

/**
 * 当饼图类型为圆环类型时，可通过此方法把半径平均分成n段，圆环的线宽为n分之1，简单理解就是调整圆环线宽的粗细
 */
- (CGFloat)radiusAverageNumberOfSegments:(WDPieChart *)pieChart;
@end

@interface WDPieChart : UIView
@property (nonatomic, weak) id<WDPieChartDataSource> dataSource;
@property (nonatomic, weak) id<WDPieChartDelegate> delegate;

@property (nonatomic, strong) UIFont * percentOnChartFont;
@property (nonatomic, assign) kPiePatternType piePatternType;
@property (nonatomic, assign) kPercentType percentType;

@property (nonatomic, assign) BOOL isShowPercent;
@property (nonatomic, assign) BOOL isShadow;
@property (nonatomic, assign) BOOL isAnimated;
@property (nonatomic, assign) CGFloat opacity;
@property (nonatomic, strong) UILabel *perLabel;
@property (nonatomic,copy) NSString *centerTitles;
@property (nonatomic,copy) NSString *pertentTitles;
///MARK: 重绘
- (void)strokePath;
@end
