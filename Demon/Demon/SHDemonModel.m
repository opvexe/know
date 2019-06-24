//
//  SHDemonModel.m
//  Demon
//
//  Created by FaceBook on 2019/6/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "SHDemonModel.h"
#import "BaseViewController.h"

@implementation SHDemonModel

- (instancetype)initWithTitle:(NSString *)title targetClass:(Class)targetClass {
    self = [super init];
    if (self) {
        self.title = title;
        self.targetClass = targetClass;
    }
    
    return self;
}

+ (instancetype)modelWithTitle:(NSString *)title targetClass:(Class)targetClass {
    return [[self alloc] initWithTitle:title targetClass:targetClass];
}


+ (NSArray<SHDemonModel *> *)demoTypeList {
    NSMutableArray *array = [NSMutableArray array];
    
    SHDemonModel *baseDemo1 = [SHDemonModel modelWithTitle:@"主控制器1" targetClass:BaseViewController.class];
    SHDemonModel *baseDemo2 = [SHDemonModel modelWithTitle:@"主控制器2" targetClass:BaseViewController.class];
    SHDemonModel *baseDemo3 = [SHDemonModel modelWithTitle:@"主控制器3" targetClass:BaseViewController.class];
    SHDemonModel *baseDemo4 = [SHDemonModel modelWithTitle:@"主控制器4" targetClass:BaseViewController.class];
    
    
    [array addObjectsFromArray:@[baseDemo1,baseDemo2,baseDemo3,baseDemo4]];
    
    return [array copy];
}


@end
