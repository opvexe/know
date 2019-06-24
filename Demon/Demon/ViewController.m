//
//  ViewController.m
//  Demon
//
//  Created by FaceBook on 2019/6/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ViewController.h"
#import "SHDemonModel.h"
#import <Masonry.h>
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray<SHDemonModel *> *demoList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    SHDemonModel *demoTypeModel = self.demoList[indexPath.row];
    cell.textLabel.text = demoTypeModel.title;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SHDemonModel *demoTypeModel = self.demoList[indexPath.row];
    
    NSLog(@"%@",demoTypeModel);
}

#pragma mark - Getter

- (NSArray *)demoList {
    if (!_demoList) {
        _demoList = [SHDemonModel demoTypeList];
    }
    return _demoList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        _tableView.rowHeight = 60;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
