//
//  WDMineTableViewCell.h
//  Mine
//
//  Created by Facebook on 2018/7/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDSettingItem.h"
@interface WDMineTableViewCell : UITableViewCell
#pragma mark 私有方法
+(instancetype)CellWithTableView:(UITableView *)tableview;
-(void)InitDataWithModel:(WDSettingItem *)model;
@end
