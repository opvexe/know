//
//  SYPaymentSucceeView.h
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPayModel.h"

@interface SYPaymentSucceeView : UIView
@property(nonatomic,strong)UIButton *completeButton;
@property(nonatomic,strong)UIButton *detailButton;
-(void)InitDataWithModel:(SYPayModel *)model;
@end
