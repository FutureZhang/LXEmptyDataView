//
//  LXTableViewController.m
//  LXEmptyDataView_Example
//
//  Created by 张莉祥 on 2018/1/31.
//  Copyright © 2018年 FutureZhang. All rights reserved.
//

#import "LXTableViewController.h"
#import <LXEmptyDataView/LXEmptyDataView.h>

@interface LXTableViewController ()
//1：暂无数据，2：加载失败，3：加载失败，重新加载，4：有数据，
@property (assign, nonatomic) NSInteger status;
@end

@implementation LXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    
    self.status = 1;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
}

- (void)refresh{
    if (self.status == 1) {
        self.status = 2;
        [self.tableView reloadData];
        return;
    }
    if (self.status == 2) {
        self.status = 3;
        [self.tableView reloadData];
        return;
    }
    if (self.status == 3) {
        self.status = 4;
        [self.tableView reloadData];
        return;
    }
    if (self.status == 4) {
        self.status = 1;
        [self.tableView reloadData];
        return;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.status == 1||self.status == 2||self.status == 3) {
        return 1;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.status == 1||self.status == 2||self.status == 3) {
        return 0;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zi行",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

#pragma mark ---------- LXEmptyDataView ----------
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView.lx_itemsCount == 0) {
        return self.tableView.frame.size.height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LXEmptyDataView *emptyDataView = [[LXEmptyDataView alloc] initWithFrame:self.tableView.frame];
    if (self.status == 1) {
        emptyDataView.image = [UIImage imageNamed:@"ic_empty_data"];
        emptyDataView.title = [NSAttributedString lx_attributedString:@"暂无数据" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
    }
    if (self.status == 2) {
        emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
        emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
    }
    if (self.status == 3) {
        emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
        emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
        emptyDataView.buttonTitle = [NSAttributedString lx_attributedString:@"重新加载" color:[UIColor blueColor] font:[UIFont systemFontOfSize:15.0]];
        emptyDataView.buttonBorderColor = [UIColor blueColor];
        emptyDataView.touchButtonBlock = ^{
            [self refresh];
        };
    }
    
    emptyDataView.touchAllViewBlock = ^{
        [self refresh];
    };
    return emptyDataView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
