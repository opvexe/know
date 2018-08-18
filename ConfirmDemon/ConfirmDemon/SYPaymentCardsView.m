//
//  SYPaymentCardsView.m
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#define  SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define  SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define  WD_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define  WD_TabbarSafeBottomMargin         (WD_iPhoneX ? 34.f : 0.f)

#import "SYPaymentCardsView.h"
#import <Masonry.h>

@interface SYPaymentMethodTabelCell ()
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation SYPaymentMethodTabelCell
+(instancetype)CellWithTableView:(UITableView *)tableview{
    static NSString *ID =@"SYPaymentMethodTabelCell";
    SYPaymentMethodTabelCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SYPaymentMethodTabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle              = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel= ({
            UILabel *iv = [[UILabel alloc] init];
            iv.textColor = [UIColor blackColor];
            iv.font = [UIFont systemFontOfSize:14.0];
            iv.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(-80.0);
            }];
            iv;
        });
    }
    return  self ;
}

-(void)InitDataWithModel:(SYPayModel *)model{
    self.titleLabel.text = model.title;
}

@end


@interface SYPaymentCardsView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *topLineView;
@property(nonatomic,strong)UITableView *listView;
@property(nonatomic,strong)NSMutableArray *lists;
@end
@implementation SYPaymentCardsView

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _backButton= ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            [btn setTitle:@"返回" forState:UIControlStateNormal];
            [btn setTitle:@"返回" forState:UIControlStateSelected];
            [btn setTitle:@"返回" forState:UIControlStateDisabled];
            [btn setTitle:@"返回" forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateDisabled];
            [btn setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateHighlighted];
            btn.adjustsImageWhenHighlighted =NO;
            btn.showsTouchWhenHighlighted =NO;
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
            iv.text = @"选择付款方式";
            iv.textColor = [UIColor blackColor];
            iv.font = [UIFont systemFontOfSize:18.0];
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH -100);
                make.top.mas_equalTo(self.backButton.mas_top);
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
            iv.estimatedSectionFooterHeight = 0;
            iv.estimatedSectionHeaderHeight = 0;
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.mas_equalTo(0);
                make.top.mas_equalTo(self.topLineView.mas_bottom);
                make.bottom.mas_equalTo(0);
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
    SYPaymentMethodTabelCell *cell  = [SYPaymentMethodTabelCell CellWithTableView:tableView];
    [cell InitDataWithModel:self.lists[indexPath.row]];
    return cell;
}

#pragma mark 适配ios11
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SYPayModel *model = self.lists[indexPath.row];
    [self.lists enumerateObjectsUsingBlock:^(SYPayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:model]) {
            obj.IsSelected = YES;
        }else{
            obj.IsSelected = NO;
        }
    }];
    [self.listView reloadData];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(PaymentCardView:didSelectedAtType:model:)]) {
        [self.delegate PaymentCardView:self didSelectedAtType:model.cardType model:model];
    }
}

@end
