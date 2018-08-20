//
//  SYAlertPayMentFooterView.h
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPayModel.h"

@interface SYAlertPayMentFooterView : UITableViewHeaderFooterView
+(instancetype)footViewWithTableView:(UITableView *)tableview;
-(void)InitDataWithModel:(SYPayModel *)model;
@end
