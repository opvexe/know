//
//  SwitchButtonView.m
//  switchButtonDemo
//
//  Created by zhanglu on 2019/4/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import "SwitchButtonView.h"
@interface SwitchButtonView()


@end

static NSInteger spaing  = 12;

@implementation SwitchButtonView

-(CGSize)converToString:(NSString *)string font:(UIFont* )font{
    return [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 1000) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}

-(instancetype)init{
    if (self =[super init]) {
      
        [self addTabTitleImageView];
    }
    return self;
}
-(void)addTabTitleImageView{
    _tabTitleImageView = ({
        UIImageView *iv = [[UIImageView alloc] init];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-7);
            make.height.mas_equalTo(self.normalFontSize+spaing);
        }];
        iv;
    });
    
}
-(void)setNormalFontSize:(CGFloat)normalFontSize{
    _normalFontSize = normalFontSize;
    [self.tabTitleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(normalFontSize + spaing);
    }];
}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.normalTabTextImage = [self txtSwapImage:title textColor:self.normalTextColor FontName:self.normalFontName fontSize:self.normalFontSize];
    self.selectTabTextImage = [self txtSwapImage:title textColor:self.selectTextColor FontName:self.selectFontName fontSize:self.selectFontSize];
    self.tabTitleImageView.image = self.normalTabTextImage;
}
-(void)setChoosed:(BOOL)choosed{
    if (choosed) {
        [self updateTabImage:self.selectTabTextImage height:self.selectFontSize bottom:-5];
    }else{
        [self updateTabImage:self.normalTabTextImage height:self.normalFontSize bottom:-7];
    }
    if (choosed != self.isSelected) {
        [UIView animateWithDuration:self.animationInterval animations:^{
            [self layoutIfNeeded];
        }];
    }
    self.selected = choosed;
}
-(void)updateTabImage:(UIImage *)image height:(CGFloat)height bottom:(CGFloat)bottom{
    self.tabTitleImageView.image = image;
    [self.tabTitleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height +spaing);
        make.bottom.mas_equalTo(bottom);
    }];
}
-(UIImage *)txtSwapImage:(NSString *)text textColor:(UIColor*)textColor FontName:(NSString *)fontName fontSize:(CGFloat )fontSize{
    if (!text.length) {
        return nil;
    }
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    
    CGSize stringFontSize = [self converToString:text font:font];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.alignment =  NSTextAlignmentCenter;
    
    style.lineBreakMode =  NSLineBreakByCharWrapping;
    style.lineSpacing =  0;
    style.paragraphSpacing =  2;
    NSDictionary *key  =@{NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:style,
                          NSForegroundColorAttributeName:textColor,
                          NSBackgroundColorAttributeName:[UIColor clearColor]
                          };
    UIGraphicsBeginImageContextWithOptions(stringFontSize, NO, [UIScreen mainScreen].scale);
    [text drawInRect:CGRectMake(0, 0, stringFontSize.width, stringFontSize.height+spaing) withAttributes:key];
    UIImage  *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
