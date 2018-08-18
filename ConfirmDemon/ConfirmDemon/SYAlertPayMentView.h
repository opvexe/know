//
//  SYAlertPayMentView.h
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPayModel.h"

@interface SYAlertPayMentView : UIView
+(SYAlertPayMentView *)creatViewComplelte:(void(^)(SYAlertPayMentView *alerPayMentView,PayMentType type))complete;
-(void)initDataSocure:(NSArray *)banks;

@end

@interface SYPaymentTabelViewCell : UITableViewCell
+(instancetype)CellWithTableView:(UITableView *)tableview;
-(void)InitDataWithModel:(SYPayModel *)model;
@end

