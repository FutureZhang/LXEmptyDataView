//
//  LXCollectionViewController.m
//  LXEmptyDataView_Example
//
//  Created by 张莉祥 on 2018/1/31.
//  Copyright © 2018年 FutureZhang. All rights reserved.
//

#import "LXCollectionViewController.h"
#import <LXEmptyDataView/LXEmptyDataView.h>

@interface LXCollectionViewController ()

//1：暂无数据，2：加载失败，3：加载失败，4：加载失败，5：有数据，
@property (assign, nonatomic) NSInteger status;

@end

@implementation LXCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"UICollectionView";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //UICollectionView 空数据、加载失败，必须先注册LXEmptyDataView
    [self.collectionView registerClass:[LXEmptyDataView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([LXEmptyDataView class])];
    
    self.status = 1;
}

- (void)refresh{
    if (self.status == 1) {
        self.status = 2;
        [self.collectionView reloadData];
        return;
    }
    if (self.status == 2) {
        self.status = 3;
        [self.collectionView reloadData];
        return;
    }
    if (self.status == 3) {
        self.status = 4;
        [self.collectionView reloadData];
        return;
    }
    if (self.status == 4) {
        self.status = 5;
        [self.collectionView reloadData];
        return;
    }
    if (self.status == 5) {
        self.status = 1;
        [self.collectionView reloadData];
        return;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.status == 1||self.status == 2||self.status == 3||self.status == 4) {
        return 1;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.status == 1||self.status == 2||self.status == 3||self.status == 4) {
        return 0;
    }
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGBValue(0X1296db);
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.frame];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%zi",indexPath.row];
    [cell.contentView addSubview:label];
    return cell;
}

/**
 collectionView每个section的高
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if ([collectionView lx_itemsCount] == 0) {
        return CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    }
    return CGSizeZero;
}
/**
 collectionView sectionHeaderView
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    LXEmptyDataView *emptyDataView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([LXEmptyDataView class]) forIndexPath:indexPath];
    [emptyDataView lx_reloadEmptyDataView];//清除重用池中缓存
    if (self.status == 1) {
        emptyDataView.image = [UIImage imageNamed:@"ic_empty_data"];
        emptyDataView.title = [NSAttributedString lx_attributedString:@"暂无数据" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
    }else if (self.status == 2) {
        emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
        emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
    }else if (self.status == 3) {
        emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
        emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
        emptyDataView.buttonTitle = [NSAttributedString lx_attributedString:@"重新加载" color:UIColorFromRGBValue(0X1296db) font:LXSystemFont15];
        emptyDataView.buttonBorderColor = UIColorFromRGBValue(0X1296db);
        emptyDataView.touchButtonBlock = ^{
            [self refresh];
        };
    }else if (self.status == 4) {
        emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
        emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
        emptyDataView.buttonTitle = [NSAttributedString lx_attributedString:@"点击返回" color:UIColorFromRGBValue(0X1296db) font:LXSystemFont15];
        emptyDataView.touchButtonBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
        };
        emptyDataView.rightButtonTitle = [NSAttributedString lx_attributedString:@"重新加载" color:UIColorFromRGBValue(0X1296db) font:LXSystemFont15];
        emptyDataView.touchRightButtonBlock = ^{
            [self refresh];
        };
        emptyDataView.buttonBorderColor = UIColorFromRGBValue(0X1296db);
        emptyDataView.buttonCornerRadius = YES;
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
