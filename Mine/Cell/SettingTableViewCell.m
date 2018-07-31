//
//  SettingTableViewCell.m
//  Mine
//
//  Created by Facebook on 2018/7/27.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

+(instancetype)CellWithTableView:(UITableView *)tableview{
    static NSString *ID = @"SettingTableViewCell";
    SettingTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return  self ;
}


-(void)InitDataWithModel:(WDSettingItem *)model{
    self.textLabel.text = model.content;
}



+(CGFloat)getCellHeight:(WDSettingItem *)model{
    return 80.0f;
}


@end
