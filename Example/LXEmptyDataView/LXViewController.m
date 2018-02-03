//
//  LXViewController.m
//  LXEmptyDataView
//
//  Created by FutureZhang on 01/31/2018.
//  Copyright (c) 2018 FutureZhang. All rights reserved.
//

#import "LXViewController.h"
#import <LXEmptyDataView/LXEmptyDataView.h>

#import "LXTableViewController.h"
#import "LXCollectionViewController.h"
#import "LXEmptyDataViewController.h"

@interface LXViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation LXViewController

static NSString * const cellId = @"cellId";

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.dataArray = @[@"【UITableView】中使用",@"【UICollectionView】中使用",@"【UIView】中使用"];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.tableFooterView = [UIView new];
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.textColor = UIColorFromRGBValue(0X1296db);
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[LXTableViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 1) {
        //初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake((self.view.frame.size.width-4)/4, self.view.frame.size.width/6);
        LXCollectionViewController *VC = [[LXCollectionViewController alloc] initWithCollectionViewLayout:layout];
        VC.collectionView.collectionViewLayout = layout;
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 2) {
        [self.navigationController pushViewController:[[LXEmptyDataViewController alloc] init] animated:YES];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
