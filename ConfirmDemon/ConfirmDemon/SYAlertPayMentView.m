//
//  SYAlertPayMentView.m
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#define  SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define  SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define  WD_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define  WD_TabbarSafeBottomMargin         (WD_iPhoneX ? 34.f : 0.f)

#import "SYAlertPayMentView.h"
#import "SYPaymentCardsView.h"
#import "SYPaymentSucceeView.h"
#import "SYAlertPayMentFooterView.h"
#import <MJExtension.h>
#import <Masonry.h>

@interface SYPaymentTabelViewCell ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIView *bottomlineView;
@end
@implementation SYPaymentTabelViewCell
+(instancetype)CellWithTableView:(UITableView *)tableview{
    static NSString *ID =@"SYPaymentTabelViewCell";
    SYPaymentTabelViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SYPaymentTabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle              = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel= ({
            UILabel *iv = [[UILabel alloc] init];
            iv.textColor = [UIColor lightGrayColor];
            iv.font = [UIFont systemFontOfSize:14.0];
            iv.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.centerY.mas_equalTo(self.contentView);
                make.width.mas_equalTo(80.0);
            }];
            iv;
        });
        
        _contentLabel= ({
            UILabel *iv = [[UILabel alloc] init];
            iv.textColor = [UIColor blackColor];
            iv.textAlignment = NSTextAlignmentRight;
            iv.font = [UIFont systemFontOfSize:14.0];
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(self.titleLabel.mas_left).mas_offset(10);
            }];
            iv;
        });
        
        _bottomlineView = ({
            UIView *iv = [[UIView alloc] init];
            iv.backgroundColor = [UIColor lightGrayColor];
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0.5);
                make.bottom.mas_equalTo(self.contentView.mas_bottom);
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(0);
            }];
            iv;
        });
        
    }
    return  self ;
}

-(void)InitDataWithModel:(SYPayModel *)model{
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.subTitle;
}

@end


@class SYPaymentContentView;
@protocol SYPaymentContentViewDelegate <NSObject>
@optional
-(void)PayMentContentView:(SYPaymentContentView *)shopView  model:(id) model;
@end

@interface SYPaymentContentView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *clearButton;
@property(nonatomic,strong)UIButton *subComitButton;
@property(nonatomic,strong)UIView *topLineView;
@property(nonatomic,strong)UITableView *listView;
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,weak) id <SYPaymentContentViewDelegate>delegate;


@end

@implementation SYPaymentContentView

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _clearButton= ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            [btn setTitle:@"关闭" forState:UIControlStateNormal];
            [btn setTitle:@"关闭" forState:UIControlStateSelected];
            [btn setTitle:@"关闭" forState:UIControlStateDisabled];
            [btn setTitle:@"关闭" forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateDisabled];
            [btn setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateHighlighted];
            btn.adjustsImageWhenHighlighted =NO;
            btn.showsTouchWhenHighlighted =NO;
            btn.tag = PayMentTypeClosed;
            [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.width.mas_equalTo(40.0);
                make.top.mas_equalTo(self.mas_top).offset(10);
                make.height.mas_equalTo(20);
            }];
            btn;
        });
        
        _titleLabel= ({
            UILabel *iv = [[UILabel alloc] init];
            iv.text = @"付款详情";
            iv.textColor = [UIColor blackColor];
            iv.font = [UIFont systemFontOfSize:18.0];
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH -100);
                make.top.mas_equalTo(self.clearButton.mas_top);
                make.height.mas_equalTo(20);
            }];
            iv;
        });
        
        _topLineView = ({
            UIView *iv = [[UIView alloc] init];
            iv.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(.5);
                make.bottom.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
                make.right.and.left.mas_equalTo(0);
            }];
            iv;
        });
        
        _subComitButton= ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            [btn setTitle:@"确认支付" forState:UIControlStateNormal];
            [btn setTitle:@"确认支付" forState:UIControlStateSelected];
            [btn setTitle:@"确认支付" forState:UIControlStateDisabled];
            [btn setTitle:@"确认支付" forState:UIControlStateHighlighted];
            //            [btn setBackgroundImage:[UIImage imageWithColor:TABARHIGHTLIGHTCOLOR] forState:UIControlStateNormal];
            //            [btn setBackgroundImage:[UIImage imageWithColor:TABARHIGHTLIGHTCOLOR] forState:UIControlStateSelected];
            //            [btn setBackgroundImage:[UIImage imageWithColor:TABARHIGHTLIGHTCOLOR] forState:UIControlStateDisabled];
            //            [btn setBackgroundImage:[UIImage imageWithColor:TABARHIGHTLIGHTCOLOR] forState:UIControlStateHighlighted];
            btn.backgroundColor = [UIColor redColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor]forState:UIControlStateDisabled];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            btn.adjustsImageWhenHighlighted =NO;
            btn.showsTouchWhenHighlighted =NO;
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            btn.layer.cornerRadius  =5;
            btn.layer.masksToBounds  = YES;
            btn.tag = PayMentTypeSubmit;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.left.mas_equalTo(10);
                make.bottom.mas_equalTo(-10);
                make.height.mas_equalTo(40);
            }];
            btn;
        });
        
        _listView = ({
            UITableView *iv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];;
            [self addSubview:iv];
            iv.showsVerticalScrollIndicator =NO;
            iv.showsHorizontalScrollIndicator =NO;
            iv.backgroundColor = [UIColor whiteColor];
            iv.separatorStyle = UITableViewCellSeparatorStyleNone;
            iv.dataSource = self;
            iv.delegate = self;
            iv.rowHeight   = 44.0;
            iv.scrollEnabled = NO;
            iv.estimatedSectionFooterHeight = 0;
            iv.estimatedSectionHeaderHeight = 0;
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.mas_equalTo(0);
                make.top.mas_equalTo(self.topLineView.mas_bottom);
                make.bottom.mas_equalTo(self.subComitButton.mas_top);
            }];
            iv;
        });
    }
    return self;
}

-(void)initDataSocure:(NSArray *)banks{
    self.lists = [NSMutableArray arrayWithArray:banks];
    [self.listView reloadData];
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SYPaymentTabelViewCell *cell  = [SYPaymentTabelViewCell CellWithTableView:tableView];
    [cell InitDataWithModel:self.lists[indexPath.row]];
    return cell;
}

#pragma mark 适配ios11
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SYAlertPayMentFooterView * footView =  [SYAlertPayMentFooterView footViewWithTableView:tableView];
    [footView InitDataWithModel:nil];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80.0f;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(PayMentContentView:model:)]) {
        [self.delegate PayMentContentView:self model:nil];
    }
}

@end


@interface SYAlertPayMentView ()<SYPaymentContentViewDelegate,SYPaymentCardsViewDelegate>
@property(nonatomic,strong)SYPaymentContentView *contentView;
@property(nonatomic,strong)SYPaymentCardsView *paymentView;
@property(nonatomic,strong)SYPaymentSucceeView *sucessView;
@property(nonatomic,copy)void(^compteleBlock)(SYAlertPayMentView *alerPayMentView,PayMentType type);
@end

@implementation SYAlertPayMentView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f];
        //        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)]];
        _contentView = ({
            SYPaymentContentView *iv = [[SYPaymentContentView alloc] init];
            [self addSubview:iv];
            iv.backgroundColor = [UIColor whiteColor];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.and.left.mas_equalTo(0);
                make.height.mas_equalTo(350);
                make.top.mas_equalTo(SCREEN_HEIGHT);
            }];
            iv.delegate = self;
            [iv.clearButton addTarget:self action:@selector(ClearAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv.subComitButton addTarget:self action:@selector(subAtion:) forControlEvents:UIControlEventTouchUpInside];
            iv;
        });
        _paymentView = ({
            SYPaymentCardsView *iv = [[SYPaymentCardsView alloc] init];
            [self addSubview:iv];
            iv.backgroundColor = [UIColor whiteColor];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(350);
                make.top.mas_equalTo(SCREEN_HEIGHT-350-WD_TabbarSafeBottomMargin);
                make.width.mas_equalTo(SCREEN_WIDTH);
            }];
            iv.delegate = self;
            [iv.backButton addTarget:self action:@selector(BackAction:) forControlEvents:UIControlEventTouchUpInside];
            iv;
        });
        
        _sucessView = ({
            SYPaymentSucceeView *iv = [[SYPaymentSucceeView alloc] init];
            [self addSubview:iv];
            iv.backgroundColor = [UIColor whiteColor];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(350);
                make.top.mas_equalTo(SCREEN_HEIGHT-350-WD_TabbarSafeBottomMargin);
                make.width.mas_equalTo(SCREEN_WIDTH);
            }];
            [iv.completeButton addTarget:self action:@selector(CompletAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv.detailButton addTarget:self action:@selector(LookDetailAction:) forControlEvents:UIControlEventTouchUpInside];
            iv;
        });
        
        [self layoutIfNeeded];
    }
    return self;
}

#pragma mark SYPaymentContentViewDelegate
-(void)PayMentContentView:(SYPaymentContentView *)shopView  model:(id) model{
    [self showPayView:self.paymentView];
    [self.paymentView initDataSocure:[self Payment]];
}

#pragma mark SYPaymentCardsViewDelegate
-(void)PaymentCardView:(SYPaymentCardsView *)shopView didSelectedAtType:(PayMentType)type model:(id)model{
    if (type ==PayMentTypeChangeCard) {
        [self dismissPayView:self.paymentView];   ///TOOD 更新银行卡片
    }else{
        if (self.compteleBlock) {
            self.compteleBlock(self,PayMentTypeBlind);
        }
    }
}

////TOOD  测试数据
-(NSArray *)Payment{
    NSArray *settings =[NSArray array];
    settings = @[
                 @{@"title":@"中国农业银行储蓄卡"},
                 @{@"title":@"招商银行储蓄卡"},
                 @{@"title":@"绑卡",@"cardType":@(PayMentTypeBlind)},
                 ];
    return [SYPayModel mj_objectArrayWithKeyValuesArray:settings];
}

-(void)initDataSocure:(NSArray *)banks{
    [self.contentView initDataSocure:banks];
}

+(SYAlertPayMentView *)creatViewComplelte:(void(^)(SYAlertPayMentView *alerPayMentView,PayMentType type))complete{
    SYAlertPayMentView *show = [[SYAlertPayMentView alloc] init];
    [show showComplete:complete];
    [show show];
    return show;
}
-(void)showComplete:(void(^)(SYAlertPayMentView *alerPayMentView,PayMentType type))complete{
    self.compteleBlock = complete;
}

#pragma mark click
//-(void)Tap:(UITapGestureRecognizer *)GestureRecognizer{
//    [self dismissView];
//}
-(void)ClearAction:(UIButton *)sender{
    [self dismissView];
    if (self.compteleBlock) {
        self.compteleBlock(self,sender.tag);
    }
}
-(void)subAtion:(UIButton *)sender{
    if (self.compteleBlock) {
        self.compteleBlock(self,sender.tag);
    }
    
    ///TOOD  交易成功页面
    [self showPayView:self.sucessView];
    
}
-(void)BackAction:(UIButton *)sender{
    [self dismissPayView:self.paymentView];
}
-(void)CompletAction:(UIButton *)sender{
    [self.sucessView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissView];
    }];
}

-(void)LookDetailAction:(UIButton *)sender{
    if (self.compteleBlock) {
        self.compteleBlock(self,PayMentTypeSucessDetail);
    }
}

-(void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(keyWindow);
    }];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_HEIGHT);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SCREEN_HEIGHT-350-WD_TabbarSafeBottomMargin);
        }];
    } completion:^(BOOL finished) {
        [self layoutIfNeeded];
    }];
}

-(void)dismissView{
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_HEIGHT);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)showPayView:(UIView *)view{
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissPayView:(UIView *)view{
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

@end
