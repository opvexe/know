//
//  ViewController.m
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ViewController.h"
#import "SYAlertPayMentView.h"
#import "SYPayModel.h"
#import <MJExtension.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn setTitle:@"Click" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)Click{
    SYAlertPayMentView  *alerView = [SYAlertPayMentView creatViewComplelte:^(SYAlertPayMentView *alerPayMentView, PayMentType type) {
        switch (type) {
            case PayMentTypeBlind:
            {
                
            }
                break;
            case PayMentTypeChangeCard:{
                
                
            }
                break;
            default:
                break;
        }
    }];
    [alerView initDataSocure:[self Payment]];
}

-(NSArray *)Payment{
    NSArray *settings =[NSArray array];
    settings = @[
                 @{@"title":@"订单信息",@"subTitle":@"商户北京***商店"},
                 @{@"title":@"付款方式",@"subTitle":@"建行"},
                 @{@"title":@"优惠",@"subTitle":@"满200元减5元"},
                 ];
    return [SYPayModel mj_objectArrayWithKeyValuesArray:settings];
}

@end
