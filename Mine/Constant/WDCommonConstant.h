//
//  WDCommonConstant.h
//  Mine
//
//  Created by FaceBooks on 2018/8/18.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef WDCommonConstant_h
#define WDCommonConstant_h


/**
 *  弱引用
 */
#ifndef weakify
#if __has_feature(objc_arc)
#define weakify(self) autoreleasepool {} __attribute__((objc_ownership(weak))) __typeof__(self) weakSelf = (self)
#endif
#endif

/**
 *  强引用
 */
#ifndef strongify
#if __has_feature(objc_arc)
#define strongify(self) try {} @finally {} _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wunused-variable\"") __attribute__((objc_ownership(strong))) __typeof__(self) self = weakSelf; _Pragma("clang diagnostic pop")
#endif
#endif

/**
 *  图片（imageNamed）
 */
#define  WDImageNamed(imageName)   [UIImage imageNamed:imageName]

/**
 *  偏好设置
 */
#define  WDUserDefaults        [NSUserDefaults standardUserDefaults]

/**
 *  通知
 */
#define  WDNotificationCenter      [NSNotificationCenter defaultCenter]

/**
 * AppDelegate
 */
#define  WDSharedApplication  [UIApplication sharedApplication].delegate

/**
 * FormatString
 */
#define FormatString(string, args...)       [NSString stringWithFormat:string, args]

/**
 * URLFromString
 */
#define URLFromString(str)                      [NSURL URLWithString:str]

/**
 * UTF8Data
 */
#define UTF8Data(str) [str dataUsingEncoding:NSUTF8StringEncoding]

/**
 *  LocalString（语言设置）
 */
#define WDLocalString(key) NSLocalizedStringFromTable(key, @"Localizable", nil)

/**
 * iOS7
 */
#define iOS7                                ((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)? NO:YES)

/**
 * iOS11
 */
#define iOS11 @available(iOS 11.0, *)
/**
 * iOS11 later
 */
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

/**
 * SCREEN_WIDTH&&SCREEN_HEIGHT
 */
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
/**
 *  iPhoneX
 */
#define  WD_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define  WD_TabbarHeight                    (WD_iPhoneX ? (49.f+34.f) : 49.f)
#define  WD_TabbarSafeBottomMargin          (WD_iPhoneX ? 34.f : 0.f)
#define NavBarHeight                        (iOS7 ? (WD_iPhoneX ? 88.f : 64.f) : 44.0)
#define WD_iPhoneXStatusBarHeight           (WD_iPhoneX ? 44.f : 0)
#define StatusBarHeight                     (iOS7 ? (WD_iPhoneX ? 44.f : 20.f) : 0.0)
#define AutomaticallyAdjustsScrollViewInsetsNO(view) if (@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;}else{self.automaticallyAdjustsScrollViewInsets = NO;}
#define WD_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

/**
 *  适配
 */
#define LSSCALWIDTH     (SCREEN_WIDTH/375.0)
#define LSSCALHEIGHT    (SCREEN_HEIGHT/667.0)
#define Number(num)                      (num*LSSCALWIDTH)
#define NumberHeight(num)                (num*LSSCALHEIGHT)

/**
 *  弹框
 */
#define ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]
/**
 *  打印
 */
#ifndef __OPTIMIZE__
#define NSLog(...) printf("%f %s %ld :%s\n",[[NSDate date]timeIntervalSince1970],strrchr(__FILE__,'/'),[[NSNumber numberWithInt:__LINE__] integerValue],[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

#endif /* WDCommonConstant_h */
