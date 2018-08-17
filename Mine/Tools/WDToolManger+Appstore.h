//
//  WDToolManger+Appstore.h
//  Mine
//
//  Created by FaceBook on 2018/8/17.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WDToolManger.h"
#import <StoreKit/StoreKit.h>

#pragma mark - Appstore相关操作类

///打开指定软件的appstore样式类型
typedef NS_ENUM(NSUInteger, JumpStoreType) {
    JumpStoreTypeInAppStore,  //强制跳转到appsStore。 Forced jump to appsStore
    JumpStoreTypeInApp,      //强制在app中弹出appStore，ios10.3版本以下无反应。Force the score pop-up window in app, the score will not respond when lower than the ios10.3 version
    JumpStoreTypeAuto         //10.3版本以下跳转appStore，10.3版本以上在app中弹出Appstore。jump to appsStore when lower than the ios10.3 version and the score pop-up window in app when higher than the ios10.3 version
};

///评分样式类型 Scoring style type
typedef NS_ENUM(NSUInteger, ScoreType) {
    ScoreTypeInAppStore,  //强制跳转到appsStore中评分。 Forced jump to appsStore
    ScoreTypeInApp,      //强制在app中弹出评分弹窗，ios10.3版本以下无反应。 Force the score pop-up window in app, the score will not respond when lower than the ios10.3 version
    ScoreTypeAuto         //10.3版本以下去appStore评分，10.3版本以上在app中弹出评分弹窗。jump to appsStore when lower than the ios10.3 version and the score pop-up window in app when higher than the ios10.3 version
};

@interface WDToolManger (Appstore)<SKStoreProductViewControllerDelegate>

/**
 使用例子：
 [WDToolManger giveScoreWithAppleID:@"1193575039" withType:ScoreTypeInApp];
 [WDToolManger giveScoreWithAppleID:@"1193575039" withType:JumpStoreTypeInAppStore];
 **/

/**
 打开appstore的预览下载页面。 Open the preview download page of Appstore
 @param appleID 指定软件的appid，在itunes后台可以看到。 The appid of the specified software can be seen in the iTunes background
 @param jumpStoreType 跳转到appstore样式类型。 Jump to Appstore style type
 */
- (void)openAppStoreWithAppleID:(NSString *)appleID withType:(JumpStoreType)jumpStoreType;

/**
 好评弹窗 High praise window
 @param appleID 评分的appid，在itunes后台可以看到。 The appid of the specified software can be seen in the iTunes background
 @param scoreType 评分样式类型。 Jump to Appstore style type
 */
- (void)giveScoreWithAppleID:(NSString *)appleID withType:(ScoreType)scoreType;
/**
 自动好评弹窗 Automatically pop-up window
 如果能在APP内好评，优先在app内弹窗好评，但是苹果为了防止滥用弹窗，一个应用内每年最多使用3次好评弹窗。所以超过三次之后，之后会使用跳转到appstore的方式。如果手机版本不能在app内弹窗好评，就会跳转到appstore去评分
 If it can be praised in the APP, priority is given to pop-ups in the app. However, in order to prevent the abuse of pop-ups, Apple uses up to 3 pop-ups in one application each year. So after more than three times, the way to jump to the appstore will be used later. If the mobile version doesn't pop up in the app, it will jump to the appstore to rate it.
 @param appleID 评分的appid
 @param hasRequestTime 已经弹窗过弹窗的次数 The number of pop-ups that have popped up
 @param totalTimeLimit 需要限制弹窗评分的次数，默认值为3，大于3的时候为默认值 Need to limit the number of pop-ups, the default value is 3, when the value is greater than 3 default
 */
- (void)giveScoreAutoTypeWithAppleID:(NSString *)appleID withHasRequestTime:(NSUInteger)hasRequestTime withTotalTimeLimit:(NSUInteger)totalTimeLimit;
@end
