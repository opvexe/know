//
//  WDSettingItem.h
//  Mine
//
//  Created by Facebook on 2018/7/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

typedef NS_ENUM(NSInteger, WDSettingItemType) {
    WDSettingItemTypeNone,
    WDSettingItemTypeArrow, // 箭头
    WDSettingItemTypeSwitch, // 开关
    WDSettingItemTypePhoto,  //图片
};

@interface WDSettingItem : BaseModel

/**
 * 图标
 */
@property (nonatomic, copy) NSString *icon;

/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;


/**
 * Cell
 */
@property (nonatomic,copy) NSString *CellClass;

/**
 * Cell 类型
 */
@property (nonatomic, assign) WDSettingItemType type;

@property(nonatomic,strong)BaseModel *baseModel;

/**
 * 设置开关
 */
@property (nonatomic, assign, getter=isSwitchOn) BOOL switchOn;
/**
 *  点击cell后要执行的操作
 */
@property (nonatomic, copy) void (^operation)(void);
@property (nonatomic, copy) void (^switchBlock)(BOOL on);
#pragma mark 私有方法
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title type:(WDSettingItemType)type;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title CellClass:(NSString *)CellClass;
+ (instancetype)itemWithModel:(BaseModel *)model CellClass:(NSString *)CellClass;

@end
