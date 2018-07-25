//
//  WDMineTableViewCell.m
//  Mine
//
//  Created by Facebook on 2018/7/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WDMineTableViewCell.h"

@interface WDMineTableViewCell()
@property(nonatomic,strong)UISwitch *SWitch;
@property(nonatomic,strong)UIImageView *photo;
@property(nonatomic,strong)WDSettingItem *model;
@end
@implementation WDMineTableViewCell

+(instancetype)CellWithTableView:(UITableView *)tableview{
    static NSString *ID = @"WDMineTableViewCell";
    WDMineTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WDMineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    _model = model;
    self.imageView.image = [UIImage imageNamed:model.icon];
    self.textLabel.text = model.title;
    
    if (model.type == WDSettingItemTypeArrow) {
       self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       self.selectionStyle = UITableViewCellSelectionStyleGray;
    }else if (model.type == WDSettingItemTypeSwitch){
        self.accessoryView  = self.SWitch;
         [self.SWitch setOn:model.switchOn animated:YES];
         self.selectionStyle = UITableViewCellSelectionStyleGray;
    }else if (model.type == WDSettingItemTypePhoto){
        self.accessoryView  = self.photo;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }else{
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
}

-(UISwitch *)SWitch{
    if (!_SWitch) {
        _SWitch = [[UISwitch alloc]init];
        [_SWitch addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _SWitch;
}

-(UIImageView *)photo{
    if (!_photo) {
        _photo = [[UIImageView alloc]init];
        _photo.image = [UIImage imageNamed:@"sound_Effect"];
    }
    return _photo;
}

- (void)switchStatusChanged:(UISwitch *)sender {
    if (self.model.switchBlock) {
        self.model.switchBlock(sender.on);
    }
}

@end
