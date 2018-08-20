//
//  SYAlertPayMentFooterView.m
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "SYAlertPayMentFooterView.h"
#import <Masonry.h>

@interface SYAlertPayMentFooterView ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *oldPriceLabel;
@property(nonatomic,strong)UILabel *newsPriceLabel;
@end

@implementation SYAlertPayMentFooterView
+(instancetype)footViewWithTableView:(UITableView *)tableview{
    static NSString *ID =@"SYAlertPayMentFooterView";
    SYAlertPayMentFooterView *headView = [tableview dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headView) {
        headView = [[SYAlertPayMentFooterView alloc] initWithReuseIdentifier:ID];
    }
    return headView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _oldPriceLabel= ({
            UILabel *iv = [[UILabel alloc] init];
            iv.textColor = [UIColor lightGrayColor];
            iv.font = [UIFont systemFontOfSize:14.0];
            iv.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(20);
                make.width.mas_lessThanOrEqualTo(150.0);
            }];
            iv;
        });
        
        _newsPriceLabel= ({
            UILabel *iv = [[UILabel alloc] init];
            iv.textColor = [UIColor blackColor];
            iv.font = [UIFont boldSystemFontOfSize:18.0];
            iv.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.oldPriceLabel.mas_bottom).mas_offset(10);
                make.right.mas_equalTo(-10);
                make.width.mas_equalTo(150.0);
            }];
            iv;
        });
        
        _titleLabel= ({
            UILabel *iv = [[UILabel alloc] init];
            iv.textColor = [UIColor blackColor];
            iv.font = [UIFont systemFontOfSize:16.0];
            iv.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.centerY.mas_equalTo(self.newsPriceLabel.mas_centerY);
                make.width.mas_equalTo(80.0);
            }];
            iv;
        });
    }
    return self;
}

-(void)InitDataWithModel:(SYPayModel *)model{
    self.titleLabel.text = @"需付款";
    self.oldPriceLabel.attributedText = [self lineStyleSingleString:@"200.00元" Color:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14.0]];
    self.newsPriceLabel.text = @"195.00元";
}

-(NSMutableAttributedString *)lineStyleSingleString:(NSString *)string Color:(UIColor *)myColor font:(UIFont *)font {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    if (string.length) {
        NSRange range =NSMakeRange(0, string.length);
        [str addAttribute:NSForegroundColorAttributeName value:myColor range:range];
        [str addAttribute:NSFontAttributeName value:font range:range];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
        return str;
    }
    return str;
}

@end
