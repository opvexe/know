//
//  WDPieChart.m
//  Mine
//
//  Created by Facebook on 2018/7/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WDPieChart.h"
#import "WDConst.h"
#import "ZFMethod.h"
#import "NSString+Category.h"

#define ZFPieChartPercentLabelTag  1000
@interface WDPieChart()
@property (nonatomic, strong) NSMutableArray * valueArray;
@property (nonatomic, strong) NSMutableArray * colorArray;
@property (nonatomic, strong) NSMutableArray * startAngleArray;
@property (nonatomic, strong) NSMutableArray * endAngleArray;
@property (nonatomic, strong) NSMutableArray * startTimeArray;
@property (nonatomic, assign) CFTimeInterval totalDuration;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat totalValue;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGPoint pieCenter;
@property (nonatomic, assign) CGFloat extendLength;
@property (nonatomic, assign) CGFloat originHeight;
@property (nonatomic, assign) CGFloat radiusSegments;
@property (nonatomic, assign) CGFloat minLimitPercent;
@property (nonatomic, strong) UILabel *centerLabel;
@end

@implementation WDPieChart

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    _startAngle = ZFRadian(-90);
    _originHeight = self.frame.size.height;
    _pieCenter = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
    _opacity = 1.f;
}

- (void)setUp{
    _piePatternType = kPieChartPatternTypeCirque;
    _isShadow = YES;
    _isShowPercent = YES;
    _isAnimated = YES;
    _extendLength = 10.f;
    _totalDuration = 0.75f;
    _percentOnChartFont = [UIFont boldSystemFontOfSize:10.f];
    _radiusSegments = 2.f;
    _minLimitPercent = 0.f;
    self.backgroundColor = [UIColor whiteColor];
}

///MARK: 绘制饼状图ShapeLayer
- (CAShapeLayer *)pieShapeLayerWithCenter:(CGPoint)center startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color duration:(CFTimeInterval)duration piePatternType:(kPiePatternType)piePatternType{
    WDPie * pie = [WDPie pieWithCenter:center radius:_radius startAngle:startAngle endAngle:endAngle color:color duration:duration piePatternType:piePatternType isAnimated:_isAnimated];
    pie.isShadow = _isShadow;
    pie.opacity = _opacity;
    pie.lineWidth = _lineWidth;
    return pie;
}

///MARK: 绘制半透明
- (WDOpaquePie *)translucencePathShapeLayerWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle index:(NSInteger)index{
    WDOpaquePie * layer = [WDOpaquePie layerWithArcCenter:_pieCenter radius:_radius + _extendLength * 0.5 startAngle:startAngle endAngle:endAngle clockwise:YES];
    layer.strokeColor = [_colorArray[index] CGColor];
    layer.lineWidth = _lineWidth + _extendLength;
    return layer;
}

///MARK: 清除所有控件
-(void)removeAllSubLayers{
    [self.startAngleArray removeAllObjects];
    [self.endAngleArray removeAllObjects];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _originHeight);
    NSArray * subviews = [NSArray arrayWithArray:self.subviews];
    for (UIView * view in subviews) {
        [view removeFromSuperview];
    }
    NSArray * subLayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer * layer in subLayers) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}

///MARK: 移除半透明视图
- (void)removeZFTranslucencePath{
    NSArray * sublayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer * layer in sublayers) {
        if ([layer isKindOfClass:[WDOpaquePie class]]) {
            [layer removeFromSuperlayer];
        }
    }
}

///MARK: 重绘
- (void)strokePath{
    [self removeAllSubLayers];
    [self removeZFTranslucencePath];
    if ([self.dataSource respondsToSelector:@selector(valueArrayInPieChart:)]) {
        self.valueArray = [NSMutableArray arrayWithArray:[self.dataSource valueArrayInPieChart:self]];
        BOOL isAllValuesZero = [[ZFMethod shareInstance] isAllValuesZero:self.valueArray];        //判断全部数值是否为0
        if (isAllValuesZero) {
            NSLog(@"当前所有数值为0，无法绘画图表");
            return;
        }
    }
    
    if ([self.dataSource respondsToSelector:@selector(colorArrayInPieChart:)]) {
        self.colorArray = [NSMutableArray arrayWithArray:[self.dataSource colorArrayInPieChart:self]];
    }
    
    if ([self.delegate respondsToSelector:@selector(radiusForPieChart:)]) {
        _radius = [self.delegate radiusForPieChart:self];
        if (_piePatternType == kPieChartPatternTypeCircle) {
            _lineWidth = _radius;
            _radius = _radius / 2;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(allowToShowMinLimitPercent:)]) {
        _minLimitPercent = [self.delegate allowToShowMinLimitPercent:self];
    }
    
    if (_piePatternType == kPieChartPatternTypeCirque) {
        if ([self.delegate respondsToSelector:@selector(radiusAverageNumberOfSegments:)]) {
            _radiusSegments = [self.delegate radiusAverageNumberOfSegments:self] > 1 ? [self.delegate radiusAverageNumberOfSegments:self] : 2.f;
        }
        _lineWidth = _radius / _radiusSegments;       //圆环线宽是以自身中心扩散，故减去自身一半的宽度
        _radius = _radius - _lineWidth / 2;
    }
    
    for (NSInteger i = 0; i < _valueArray.count; i++) {
        if (_isAnimated) {
            NSDictionary * userInfo = @{@"index":@(i)};
            NSTimer * timer = [NSTimer timerWithTimeInterval:[self.startTimeArray[i] floatValue] target:self selector:@selector(timerAction:) userInfo:userInfo repeats:NO];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        }else{
            [self showEachPieShapeLayer:i];
        }
    }
}

///MARK: 绘制圆饼
- (void)showEachPieShapeLayer:(NSInteger)i{
    CGFloat angle = [self countAngle:[_valueArray[i] floatValue]];     //计算每个item所占角度大小
    [self.layer addSublayer:[self pieShapeLayerWithCenter:_pieCenter startAngle:_startAngle endAngle:_startAngle + angle color:_colorArray[i] duration:[self countDuration:i] piePatternType:_piePatternType]];
    _centerPoint = [self getBezierPathCenterPointWithStartAngle:_startAngle endAngle:_startAngle + angle];
    [_startAngleArray addObject:@(_startAngle)];
    [_endAngleArray addObject:@(_startAngle + angle)];
    _startAngle += angle;    //临时记录下一个path的开始角度
    _isShowPercent ? [self creatPercentLabel:i] : nil;
}


///MARK: 计算每个item所占角度大小
- (CGFloat)countAngle:(CGFloat)value{
    CGFloat percent = value / _totalValue;     //计算百分比
    CGFloat angle = M_PI * 2 * percent;     //需要多少度的圆弧
    return angle;
}

///MARK: 计算每个path的中心点
- (CGPoint)getBezierPathCenterPointWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    CGFloat halfAngle = (endAngle - startAngle) / 2;     //一半角度(弧度)
    CGFloat centerAngle = halfAngle + startAngle;     //中心角度(弧度)
    CGFloat realAngle = ZFAngle(centerAngle);     //中心角度(角度)
    CGFloat center_xPos = ZFCos(realAngle) * _radius + _pieCenter.x;
    CGFloat center_yPos = ZFSin(realAngle) * _radius + _pieCenter.y;
    return CGPointMake(center_xPos, center_yPos);
}

///MARK: 计算每个动画的时长
- (CFTimeInterval)countDuration:(NSInteger)index{
    if (_totalDuration < 0.1f) {
        _totalDuration = 0.1f;
    }
    float count = _totalDuration / 0.1f;
    CGFloat averageAngle =  M_PI * 2 / count;
    CGFloat time = [self countAngle:[_valueArray[index] floatValue]] / averageAngle * 0.1;
    return time;
}

///MARK: 定时器
- (void)timerAction:(NSTimer *)sender{
    _index = [[sender.userInfo objectForKey:@"index"] integerValue];
    [self showEachPieShapeLayer:_index];
    [sender invalidate];
    sender = nil;
}

///MARK: 计算百分比
- (NSString *)getPercent:(NSInteger)index{
    CGFloat percent = [_valueArray[index] floatValue] / _totalValue * 100;
    NSString * string;
    if (self.percentType == kPercentTypeDecimal) {
        string = [NSString stringWithFormat:@"%.2f",percent];
    }else if (self.percentType == kPercentTypeInteger){
        string = [NSString stringWithFormat:@"%d",(int)roundf(percent)];
    }else if (self.percentType == kPercentTypeNone){
        string = nil;
    }
    
    if ([string floatValue] < _minLimitPercent) {
        string = @"";
    }else{
        string = [NSString stringWithFormat:@"%@%%",string];
    }
    return string;
}

///MARK: 圆饼点击事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y > _pieCenter.y + _radius + _extendLength) {  ///上
        NSLog(@"区域范围外 ==>下");
        [self removeZFTranslucencePath];
        self.perLabel.frame = CGRectZero;
        return;
    }
    
    if (point.y < _pieCenter.y - _radius - _extendLength) {  ///下
        NSLog(@"区域范围外 ==>上");
        [self removeZFTranslucencePath];
        self.perLabel.frame = CGRectZero;
        return;
    }
    
    if (point.x < _pieCenter.x -_radius -_extendLength) {  ///左
        NSLog(@"区域范围外 ==>左");
        [self removeZFTranslucencePath];
        self.perLabel.frame = CGRectZero;
        return;
    }
    
    if (point.x > _pieCenter.x +_radius +_extendLength) {
        NSLog(@"区域范围外 ==>右");
        [self removeZFTranslucencePath];
         self.perLabel.frame = CGRectZero;
        return;
    }
    
    
    CGFloat x = (point.x - _pieCenter.x);
    CGFloat y = (point.y - _pieCenter.y);
    CGFloat radian = atan2(y, x);
    if (y < 0 && x < 0) {     //当超过180度时，要加2π
        radian = radian + ZFRadian(360);
    }
    
    for (NSInteger i = 0; i < _startAngleArray.count; i++) {     //判断点击位置的角度在哪个path范围上
        CGFloat startAngle = [_startAngleArray[i] floatValue];
        CGFloat endAngle = [_endAngleArray[i] floatValue];
        
        if (radian >= startAngle && radian < endAngle) {
            [self removeZFTranslucencePath];
            [self.layer addSublayer:[self translucencePathShapeLayerWithStartAngle:startAngle endAngle:endAngle index:i]];
            self.perLabel.frame = CGRectMake(point.x, point.y, 100, 40);
            [self bringSubviewToFront:self.perLabel];
            UILabel *percentLabel = [self viewWithTag:ZFPieChartPercentLabelTag + i];
            [self bringSubviewToFront:percentLabel];
            if ([self.delegate respondsToSelector:@selector(pieChart:didSelectPathAtIndex:)]) {
                [self.delegate pieChart:self didSelectPathAtIndex:i];
            }
            return;
        }
    }
}

///MARK: 增加百分比Label
- (void)creatPercentLabel:(NSInteger)i{
    NSString * string = [self getPercent:i];
//    CGRect rect = [string stringWidthRectWithSize:CGSizeMake(0, 0) font:_percentOnChartFont];
//    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
//    label.text = string;
//    label.alpha = 0.f;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor clearColor];
//    label.font = _percentOnChartFont;
//    label.center = _centerPoint;
//    label.tag = ZFPieChartPercentLabelTag + i;
//    [self addSubview:label];
//    [UIView animateWithDuration:[self countDuration:i] animations:^{
//        label.alpha = 1.f;
//    }];
//    label.textColor = [UIColor whiteColor];
}

////MARK: 懒加载
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self commonInit];
}

-(UILabel *)perLabel{
    if (!_perLabel) {
        _perLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _perLabel.textAlignment = NSTextAlignmentCenter;
        _perLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
        [self addSubview:_perLabel];
        _perLabel.layer.masksToBounds = YES;
        _perLabel.layer.cornerRadius = 5.0;
        _perLabel.font = _percentOnChartFont;
        _perLabel.textColor = [UIColor whiteColor];
    }
    return _perLabel;
}

-(UILabel *)centerLabel{
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_centerLabel];
        _centerLabel.font = [UIFont systemFontOfSize:16.0];
        _centerLabel.textColor = [UIColor blackColor];
        _centerLabel.frame = CGRectMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2, 80.0, 40.0);
    }
    return _centerLabel;
}

- (void)setValueArray:(NSMutableArray *)valueArray{
    _valueArray = valueArray;
    _totalValue = 0;
    [self.startTimeArray removeAllObjects];
    CFTimeInterval startTime = 0.f;
    for (NSInteger i = 0; i < valueArray.count; i++) {     //计算总数
        _totalValue += [valueArray[i] floatValue];
    }
    for (NSInteger i = 0; i < valueArray.count; i++) {     //计算每个path的开始时间
        [self.startTimeArray addObject:[NSNumber numberWithDouble:startTime]];
        CFTimeInterval duration = [self countDuration:i];
        startTime += duration;
    }
}

- (NSMutableArray *)colorArray{
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}

- (NSMutableArray *)startAngleArray{
    if (!_startAngleArray) {
        _startAngleArray = [NSMutableArray array];
    }
    return _startAngleArray;
}

- (NSMutableArray *)endAngleArray{
    if (!_endAngleArray) {
        _endAngleArray = [NSMutableArray array];
    }
    return _endAngleArray;
}

- (NSMutableArray *)startTimeArray{
    if (!_startTimeArray) {
        _startTimeArray = [NSMutableArray array];
    }
    return _startTimeArray;
}

- (void)setCenterTitles:(NSString *)centerTitles{
    _centerTitles = centerTitles;
    self.centerLabel.text = centerTitles;
}

-(void)setPertentTitles:(NSString *)pertentTitles{
    _pertentTitles = pertentTitles;
    self.perLabel.text = pertentTitles;
}




@end
