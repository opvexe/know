//
//  ViewController.m
//  switchButtonDemo
//
//  Created by zhanglu on 2019/4/17.
//  Copyright © 2019 edz. All rights reserved.
//

#import "ViewController.h"
#import "SwitchTitleScrolloView.h"
@interface ViewController ()
@property(nonatomic,strong)SwitchTitleScrolloView *titleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleView = ({
        SwitchTitleScrolloView *iv = [[SwitchTitleScrolloView alloc] init];
        [self.view addSubview:iv];
        iv.backgroundColor = [UIColor yellowColor];
        iv.titles = @[@"测试1",@"测试2",@"测试3"];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.right.and.left.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        iv;
    });
}


@end
