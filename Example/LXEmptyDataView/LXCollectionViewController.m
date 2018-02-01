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

//1：暂无数据，2：加载失败，3：有数据，
@property (assign, nonatomic) NSInteger status;

@end

@implementation LXCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.status = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[LXEmptyDataView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([LXEmptyDataView class])];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
        self.status = 1;
        [self.collectionView reloadData];
        return;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.status == 1||self.status == 2) {
        return 1;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.status == 1||self.status == 2) {
        return 0;
    }
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    
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
    LXEmptyDataView *emptyDataView;
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        if (!emptyDataView) {
            emptyDataView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([LXEmptyDataView class]) forIndexPath:indexPath];
            if (self.status == 1) {
                emptyDataView.image = [UIImage imageNamed:@"ic_empty_data"];
                emptyDataView.title = [NSAttributedString lx_attributedString:@"暂无数据" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
            }
            if (self.status == 2) {
                emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
                emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
            }
            
            emptyDataView.touchAllViewBlock = ^{
                [self refresh];
            };
        }
    }
    return emptyDataView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
