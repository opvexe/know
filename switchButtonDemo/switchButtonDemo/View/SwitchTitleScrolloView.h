//
//  SwitchTitleScrolloView.h
//  switchButtonDemo
//
//  Created by zhanglu on 2019/4/22.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchButtonView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SwitchTitleScrolloView : UIView
@property(nonatomic,strong)NSArray<NSString*>*titles;
/**
 选中字大小
 */
@property(nonatomic,assign)CGFloat selectFontSize;

/**
 
 */
@property(nonatomic,assign)CGFloat normalFontSize;
/**
 Description
 */
@property(nonatomic,copy)NSString *normalFontName;

@property(nonatomic,strong)UIView *slideLightView;


/**
 <#Description#>
 */
@property(nonatomic,copy)NSString *selectFontName;
@property(nonatomic,strong)UIColor *normalTextColor;
@property(nonatomic,strong)UIColor *selectTextColor;
@property(nonatomic,assign)NSTimeInterval animationInterval;
@property(nonatomic,assign)NSInteger currentIndex;
-(void)didSelectedComplete:(void(^)(NSInteger  index))Complete;
@end

NS_ASSUME_NONNULL_END
