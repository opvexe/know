//
//  SHDemonModel.h
//  Demon
//
//  Created by FaceBook on 2019/6/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHDemonModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) Class targetClass;

- (instancetype)initWithTitle:(NSString *)title targetClass:(Class)targetClass;

+ (instancetype)modelWithTitle:(NSString *)title targetClass:(Class)targetClass;

+ (NSArray<SHDemonModel *> *)demoTypeList;

@end

NS_ASSUME_NONNULL_END
