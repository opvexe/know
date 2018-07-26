//
//  ViewController.m
//  Mine
//
//  Created by Facebook on 2018/7/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "ViewController.h"
#import "WDSettingGroup.h"
#import "WDMineTableViewCell.h"
#import <Masonry.h>
#import "AccountBookViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableListView;
@property(nonatomic,strong)NSMutableArray *lists;
@end

@implementation ViewController

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
    WDSettingItem *notice = [WDSettingItem itemWithIcon:nil title:@"AccountBook" type:WDSettingItemTypeNone];
    notice.operation = ^{
        [self.navigationController pushViewController:[AccountBookViewController new] animated:YES];
    };
    WDSettingItem *help = [WDSettingItem itemWithIcon:@"MoreHelp" title:@"Arrow" type:WDSettingItemTypeArrow];
    help.operation = ^{
        NSLog(@"Arrow");
    };
    WDSettingItem *detail = [WDSettingItem itemWithIcon:nil title:@"Switch" type:WDSettingItemTypeSwitch];
    detail.switchBlock = ^(BOOL on) {
        NSLog(@"Switch");
    };
    WDSettingItem *photo = [WDSettingItem itemWithIcon:nil title:@"photo" type:WDSettingItemTypePhoto];
    photo.operation = ^{
        NSLog(@"Photo");
    };
    
    WDSettingGroup *group = [[WDSettingGroup alloc] init];
    group.header = @"区头";
    group.items = @[notice,help,detail,photo];
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
    WDMineTableViewCell *cell = [WDMineTableViewCell CellWithTableView:tableView];
    WDSettingGroup *group = self.lists[indexPath.section];
    [cell InitDataWithModel:group.items[indexPath.row]];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    WDSettingGroup *group = self.lists[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    WDSettingGroup *group = self.lists[section];
    return group.footer;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 30.0f;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30.0f;
//}

@end
