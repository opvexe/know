//
//  SwitchButtonView.h
//  switchButtonDemo
//
//  Created by zhanglu on 2019/4/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface SwitchButtonView : UIControl
/**
 选中字大小
 */
@property(nonatomic,assign)CGFloat selectFontSize;

/**
 
 */
@property(nonatomic,assign)CGFloat normalFontSize;
/**
 <#Description#>
 */
@property(nonatomic,copy)NSString *normalFontName;

/**
 <#Description#>
 */
@property(nonatomic,copy)NSString *selectFontName;
/**
 
 */
@property(nonatomic,strong)UIImageView *tabTitleImageView;

/**
 
 */
@property(nonatomic,strong)UIImage *normalTabTextImage;

/**
 <#Description#>
 */
@property(nonatomic,strong)UIImage *selectTabTextImage;

/**
 <#Description#>
 */
@property(nonatomic,strong)UIColor *normalTextColor;

/**
 
 */
@property(nonatomic,strong)UIColor *selectTextColor;

/**
 
 */
@property(nonatomic,assign)NSTimeInterval animationInterval;

/**
 <#Description#>
 */
@property(nonatomic,copy)NSString *title;



/**
 <#Description#>
 */
@property(nonatomic,assign)BOOL choosed;



@end

NS_ASSUME_NONNULL_END
