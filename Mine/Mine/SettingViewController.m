//
//  SettingViewController.m
//  Mine
//
//  Created by Facebook on 2018/7/27.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SettingViewController.h"
#import "WDSettingGroup.h"
#import "WDSettingItem.h"
#import <Masonry.h>
#import "BaseTableViewCell.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableListView;
@property(nonatomic,strong)NSMutableArray *lists;
@end

@implementation SettingViewController

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray arrayWithCapacity:0];
    }
    return _lists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置";
    [self loadDataSouce];
    
    _tableListView = ({
        UITableView *iv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];;
        [self.view addSubview:iv];
        iv.showsVerticalScrollIndicator =NO;
        iv.showsHorizontalScrollIndicator =NO;
        iv.dataSource = self;
        iv.delegate = self;
        iv.estimatedRowHeight = 0;
        iv.estimatedSectionFooterHeight = 0;
        iv.estimatedSectionHeaderHeight = 0;
        iv.tableFooterView  =[UIView new];
        iv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(80.0);
            make.left.right.bottom.mas_equalTo(0);
        }];
        iv;
    });
}

-(void)loadDataSouce{
//    WDSettingItem *Setting = [WDSettingItem itemWithIcon:nil title:@"WDSettingItem" CellClass:@"SettingTableViewCell"];
//    Setting.operation = ^{
//
//    };
//    WDSettingItem *Mine = [WDSettingItem itemWithIcon:nil title:@"WDSettingItem" CellClass:@"WDMineTableViewCell"];
//    Mine.operation = ^{
//
//    };
    
    BaseModel *model = [[BaseModel alloc]init];
    model.content = @"测试model数据";
    WDSettingItem *Setting = [WDSettingItem itemWithModel:model CellClass:@"SettingTableViewCell"];
    
    
    WDSettingGroup *group = [[WDSettingGroup alloc] init];
    group.header = @"区头";
//    group.items = @[Setting,Mine];
    group.items = @[Setting];
    group.footer = @"我是区尾，我是区尾，我是区尾，我是区尾，我是区尾，我是区尾，我是区尾，我是区尾，我是区尾。";
    [self.lists addObject:group];
    
    [self.tableListView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.lists.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WDSettingGroup *group = self.lists[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDSettingGroup *group = self.lists[indexPath.section];
    WDSettingItem *model = group.items[indexPath.row];
    BaseTableViewCell *cell  = [NSClassFromString(model.CellClass) CellWithTableView:tableView];
    [cell InitDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WDSettingGroup *group = self.lists[indexPath.section];
    WDSettingItem *item = group.items[indexPath.row];
    if (item.operation) {
        item.operation();
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDSettingGroup *group = self.lists[indexPath.section];
    WDSettingItem *item = group.items[indexPath.row];
    return [NSClassFromString(item.CellClass) getCellHeight:item];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    WDSettingGroup *group = self.lists[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    WDSettingGroup *group = self.lists[section];
    return group.footer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
