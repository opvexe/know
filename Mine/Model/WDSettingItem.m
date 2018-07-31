//
//  WDSettingItem.m
//  Mine
//
//  Created by Facebook on 2018/7/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WDSettingItem.h"

@implementation WDSettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title type:(WDSettingItemType)type{
    WDSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    return item;
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title CellClass:(NSString *)CellClass{
    WDSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.CellClass = CellClass;
    return item;
}

+ (instancetype)itemWithModel:(BaseModel *)model CellClass:(NSString *)CellClass{
    WDSettingItem *item = [[self alloc] init];
    item.CellClass = CellClass;
    item.baseModel = model;
    return item;
}

@end
