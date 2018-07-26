//
//  AccountBookViewController.m
//  Mine
//
//  Created by Facebook on 2018/7/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AccountBookViewController.h"
#import "AccountBookHeadView.h"
#import "WDPieChart.h"

#define ZFColor(r, g, b, a)    [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a]
@interface AccountBookViewController ()<WDPieChartDataSource, WDPieChartDelegate>
@property(nonatomic,strong)AccountBookHeadView *headView;
@property (nonatomic, strong) WDPieChart * pieChart;
@end

@implementation AccountBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"账本";
    [self WDSinitConfingViews];
}

- (void)WDSinitConfingViews{
    
    self.pieChart = [[WDPieChart alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.pieChart.dataSource = self;
    self.pieChart.delegate = self;
    self.pieChart.percentType = kPercentTypeInteger;
    self.pieChart.isAnimated = NO;
    self.pieChart.isShadow = NO;
    self.pieChart.isShowPercent = YES;
    self.pieChart.centerTitles = @"圆饼中心数据测试";
    [self.pieChart strokePath];
    [self.view addSubview:self.pieChart];
}

#pragma mark WDPieChartDelegate
- (NSArray *)valueArrayInPieChart:(WDPieChart *)chart{
    return @[@"50", @"256", @"300", @"283", @"490", @"236"];
}

- (NSArray *)colorArrayInPieChart:(WDPieChart *)chart{
    return @[ZFColor(71, 204, 255, 1), ZFColor(253, 203, 76, 1), ZFColor(214, 205, 153, 1), ZFColor(78, 250, 188, 1), ZFColor(16, 140, 39, 1), ZFColor(45, 92, 34, 1)];
}
- (void)pieChart:(WDPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index{
    NSLog(@"第%ld个",(long)index);
    self.pieChart.pertentTitles = [NSString stringWithFormat:@"测试数据 %ld",index];
}

- (CGFloat)allowToShowMinLimitPercent:(WDPieChart *)pieChart{
    return 5.f;
}

- (CGFloat)radiusForPieChart:(WDPieChart *)pieChart{
    return 120.f;
}

- (CGFloat)radiusAverageNumberOfSegments:(WDPieChart *)pieChart{
    return 2.f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
