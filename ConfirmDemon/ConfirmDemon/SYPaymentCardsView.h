//
//  SYPaymentCardsView.h
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPayModel.h"

@class SYPaymentCardsView;
@protocol SYPaymentCardsViewDelegate <NSObject>
@optional
-(void)PaymentCardView:(SYPaymentCardsView *)shopView didSelectedAtType:(PayMentType)type model:(id) model;
@end

@interface SYPaymentCardsView : UIView
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,weak) id <SYPaymentCardsViewDelegate>delegate;
-(void)initDataSocure:(NSArray *)banks;
@end


@interface SYPaymentMethodTabelCell : UITableViewCell
+(instancetype)CellWithTableView:(UITableView *)tableview;
-(void)InitDataWithModel:(SYPayModel *)model;
@end
