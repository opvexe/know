//
//  SYPayModel.h
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PayMentType) {
    /**
     * 关闭
     */
    PayMentTypeClosed,
    /**
     * 提交支付
     */
    PayMentTypeSubmit,
    /**
     * 成功交易详情
     */
    PayMentTypeSucessDetail,
    /**
     * 绑卡
     */
    PayMentTypeBlind,
    /**
     * 更换银行卡
     */
    PayMentTypeChangeCard,
};


@interface SYPayModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subTitle;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,assign)BOOL IsSelected;
@property(nonatomic,assign)PayMentType cardType;

@end
