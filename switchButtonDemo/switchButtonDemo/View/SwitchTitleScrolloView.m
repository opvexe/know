//
//  SwitchTitleScrolloView.m
//  switchButtonDemo
//
//  Created by zhanglu on 2019/4/22.
//  Copyright © 2019 edz. All rights reserved.
//

#import "SwitchTitleScrolloView.h"
#import "UIView+WY_Extenison.h"
typedef void(^DidClick)(NSInteger  index);

@interface SwitchTitleScrolloView ()
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIScrollView *backgroundScrollView;
@property(nonatomic,strong)UIView *bottomLineView;
@property(nonatomic,strong)NSMutableArray *titlesButtons;
@property(nonatomic,copy)DidClick  clickBlock;
@end
#define HEXCOLORA(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]
@implementation SwitchTitleScrolloView
-(instancetype)init{
    if (self =[super init]) {
        self.currentIndex = 0 ;
        self.normalFontSize = 14;
        self.selectFontSize = 19;
        self.normalTextColor =  HEXCOLORA(0x969696, 1.0) ;
        self.selectTextColor = HEXCOLORA(0x000000, 1.0);
        self.animationInterval = 0.5;
        self.selectFontName = @"PingFangSC-Medium";
        self.normalFontName = @"PingFangSC-Medium";
        [self addScrollView];
    }
    return self;
}

-(void)addScrollView{
    _backgroundScrollView = ({
        UIScrollView *iv = [[UIScrollView alloc] init];
        iv.showsVerticalScrollIndicator = NO;
        iv.showsVerticalScrollIndicator = NO;
        iv.clipsToBounds = NO;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        iv;
    });
    _contentView = ({
        UIView *iv = [[UIView alloc] init];
        [self.backgroundScrollView addSubview:iv];
        iv.clipsToBounds = NO;
        iv.opaque = NO;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.backgroundScrollView);
            make.height.mas_equalTo(self.backgroundScrollView);
        }];
        iv;
    });
    
}
-(void)addConstraintForSubTabs{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    MASViewAttribute *leftConstraint = self.contentView.mas_left;
    for (int i = 0 ; i<self.titlesButtons.count; i++) {
        SwitchButtonView *bt = self.titlesButtons[i];
        [self.contentView addSubview:bt];
        [self addConstraintForButton:bt leftSlibling:leftConstraint];
        leftConstraint = bt.mas_right;
        
        if (i == 0) {
            _slideLightView = ({
                UIView *iv = [[UIView alloc]init];
                iv.backgroundColor = [UIColor purpleColor];
                [self.contentView addSubview:iv];
                [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(-2);
                    make.height.mas_equalTo(2);
                    make.centerX.mas_equalTo(bt);
                    make.width.mas_equalTo(20);
                }];
                iv;
            });
        }
    }
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(leftConstraint);
    }];
}
-(void)addConstraintForButton:(SwitchButtonView *)sender leftSlibling:(MASViewAttribute*)leftSlibling{
    NSInteger leftOffset = sender.tag == 0?17:18;
    UIFont * font = [UIFont fontWithName:self.normalFontName size:self.normalFontSize];
    if (self.currentIndex ==sender.tag) {
        sender.choosed = YES;
        sender.selected  = YES;
        font = [UIFont fontWithName:self.selectFontName size:self.selectFontSize];
    }
    CGSize size = [self converToString:sender.title font:font];
    [sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSlibling).offset(leftOffset);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
}
-(void)updateConstraintAtIndex:(NSInteger )index{
    if (self.currentIndex ==index) {
        return;
    }
    SwitchButtonView *currentBt = self.titlesButtons[index];
    SwitchButtonView *lastBt = self.titlesButtons[self.currentIndex];
    currentBt.choosed = YES;
    lastBt.choosed = NO;
    [currentBt mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self converToString:currentBt.title font:[UIFont fontWithName:self.selectFontName size:self.selectFontSize]].width);
    }];
    [lastBt mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self converToString:lastBt.title font:[UIFont fontWithName:self.normalFontName size:self.normalFontSize]].width);
    }];
    
    [_slideLightView.layer removeAllAnimations];
    CAAnimationGroup *group =[[CAAnimationGroup alloc]init];
    group.duration = 0.5f;
    group.beginTime = CACurrentMediaTime() +0.5f;
    group.repeatCount = MAXFLOAT;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *scale_d = [CABasicAnimation animation];
    scale_d.keyPath = @"transform.scale.x";
    scale_d.fromValue = @(1.0f);
    scale_d.toValue = @(1.0f*currentBt.width);
    
    CABasicAnimation *scale_x = [CABasicAnimation animation];
    scale_x.keyPath = @"transform.scale.x";
    scale_x.fromValue = @(1.0f*currentBt.width);
    scale_x.toValue = @(1.0f*lastBt.width);
    
    [group setAnimations:@[scale_d,scale_x]];
    [self.slideLightView.layer addAnimation:group forKey:nil];
    
    [UIView animateWithDuration:self.animationInterval animations:^{
        [self layoutIfNeeded];
    }];
    self.currentIndex = index;
}
#pragma mark setter getter
-(void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
    self.titlesButtons = [NSMutableArray arrayWithCapacity:titles.count];
    for (int i = 0 ; i <titles.count; i++) {
        SwitchButtonView * bt  = [[SwitchButtonView alloc] init];
        bt.selectTextColor = self.selectTextColor;
        bt.normalTextColor = self.normalTextColor;
        bt.selectFontName = self.selectFontName;
        bt.normalFontName = self.normalFontName;
        bt.selectFontSize = self.selectFontSize;
        bt.normalFontSize = self.normalFontSize;
        bt.title = titles[i];
        bt.animationInterval = self.animationInterval;
        bt.tag = i ;
        [bt addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesButtons addObject:bt];
    }
    
    [self addConstraintForSubTabs];
}

-(void)Click:(SwitchButtonView *)sender{
    [self updateConstraintAtIndex:sender.tag];
    
    if (self.clickBlock) {
        self.clickBlock(sender.tag);
    }
}
#pragma mark  public method
-(void)didSelectedComplete:(void(^)(NSInteger  index))Complete{
    self.clickBlock = Complete;
}
-(CGSize)converToString:(NSString *)string font:(UIFont* )font{
    return [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 1000) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end
