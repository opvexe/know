//
//  SYPaymentSucceeView.m
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#define  SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define  SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define  WD_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define  WD_TabbarSafeBottomMargin         (WD_iPhoneX ? 34.f : 0.f)

#import "SYPaymentSucceeView.h"
#import <Masonry.h>

@interface SYPaymentSucceeView ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *topLineView;
@property(nonatomic,strong)UILabel *subtitleLabel;
@property(nonatomic,strong)UIButton *paymentCompletButton;
@end
@implementation SYPaymentSucceeView

- (instancetype)init{
    self = [super init];
    if (self) {
        _completeButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            [btn setTitle:@"完成" forState:UIControlStateNormal];
            [btn setTitle:@"完成" forState:UIControlStateSelected];
            [btn setTitle:@"完成" forState:UIControlStateDisabled];
            [btn setTitle:@"完成" forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blueColor]  forState:UIControlStateDisabled];
            [btn setTitleColor:[UIColor blueColor]  forState:UIControlStateHighlighted];
            btn.adjustsImageWhenHighlighted =NO;
            btn.showsTouchWhenHighlighted =NO;
            [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.width.mas_equalTo(40.0);
                make.top.mas_equalTo(self.mas_top).offset(10);
                make.height.mas_equalTo(20);
            }];
            btn;
        });
        
        _titleLabel= ({
            UILabel *iv = [[UILabel alloc] init];
            iv.text = @"选择付款方式";
            iv.textColor = [UIColor blackColor];
            iv.font = [UIFont systemFontOfSize:18.0];
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH -100);
                make.top.mas_equalTo(self.completeButton.mas_top);
                make.height.mas_equalTo(20);
            }];
            iv;
        });
        
        _topLineView = ({
            UIView *iv = [[UIView alloc] init];
            iv.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(1.0);
                make.bottom.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
                make.right.and.left.mas_equalTo(0);
            }];
            iv;
        });
        
        _paymentCompletButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            [btn setTitle:@"付款成功" forState:UIControlStateNormal];
            [btn setTitle:@"付款成功" forState:UIControlStateSelected];
            [btn setTitle:@"付款成功" forState:UIControlStateDisabled];
            [btn setTitle:@"付款成功" forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blueColor]  forState:UIControlStateDisabled];
            [btn setTitleColor:[UIColor blueColor]  forState:UIControlStateHighlighted];
            btn.adjustsImageWhenHighlighted =NO;
            btn.showsTouchWhenHighlighted =NO;
            [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(30.0);
                make.centerX.mas_equalTo(self);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            btn;
        });
        
        _subtitleLabel = ({
            UILabel *iv = [[UILabel alloc] init];
            iv.text = @"已经成功付款1000块钱，优惠5元";
            iv.textColor = [UIColor grayColor];
            iv.font = [UIFont systemFontOfSize:14.0];
            iv.textAlignment = NSTextAlignmentCenter;
            iv.numberOfLines = 0;
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.paymentCompletButton.mas_bottom).mas_offset(10);
                make.left.mas_equalTo(20);
                make.right.mas_equalTo(-20);
            }];
            iv;
        });
        
        _detailButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            [btn setTitle:@"查看交易详情" forState:UIControlStateNormal];
            [btn setTitle:@"查看交易详情" forState:UIControlStateSelected];
            [btn setTitle:@"查看交易详情" forState:UIControlStateDisabled];
            [btn setTitle:@"查看交易详情" forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blueColor]  forState:UIControlStateDisabled];
            [btn setTitleColor:[UIColor blueColor]  forState:UIControlStateHighlighted];
            btn.adjustsImageWhenHighlighted =NO;
            btn.showsTouchWhenHighlighted =NO;
            [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.subtitleLabel.mas_bottom).mas_offset(20);
                make.centerX.mas_equalTo(self);
                make.width.mas_equalTo(120.0);
            }];
            btn;
        });
    }
    return self;
}

-(void)InitDataWithModel:(SYPayModel *)model{
    
}
@end
