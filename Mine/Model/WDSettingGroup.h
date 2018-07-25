//
//  WDSettingGroup.h
//  Mine
//
//  Created by Facebook on 2018/7/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDSettingGroup : NSObject

/**
 * 头部标题
 */
@property (nonatomic, copy) NSString *header;

/**
 * 尾部标题
 */
@property (nonatomic, copy) NSString *footer;

/**
 * Cell标题
 */
@property (nonatomic, strong) NSArray *items;
@end
