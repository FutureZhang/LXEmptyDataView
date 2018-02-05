# LXEmptyDataView

[![Build Status](https://travis-ci.org/FutureZhang/LXEmptyDataView.svg?branch=master)](https://travis-ci.org/FutureZhang/LXEmptyDataView)
[![Version](https://img.shields.io/cocoapods/v/LXEmptyDataView.svg?style=flat)](http://cocoapods.org/pods/LXEmptyDataView)
[![License](https://img.shields.io/cocoapods/l/LXEmptyDataView.svg?style=flat)](http://cocoapods.org/pods/LXEmptyDataView)
[![Platform](https://img.shields.io/cocoapods/p/LXEmptyDataView.svg?style=flat)](http://cocoapods.org/pods/LXEmptyDataView)

## iOS中界面出现空白页（暂无数据、加载失败......）时的占位图。
## 支持所有View，例如：UITableView、UICollectionView、UIView等。

## 一. 效果图展示

![preview](https://github.com/FutureZhang/LXEmptyDataView/blob/master/SampleImage/preview.png)

## 二. 集成方式

### 1. Cocoapods方式集成: 
```
pod 'LXEmptyDataView'

使用时导入头文件：#import <LXEmptyDataView/LXEmptyDataView.h>
```

### 2. 手动下载集成: 
```
直接将LXEmptyDataView.h和LXEmptyDataView.m两个文件复制到你的工程中

使用时导入头文件：#import "LXEmptyDataView.h"
```

## 三. 示例代码（详细示例代码请查看项目demo）

### 1. UITableView使用

![UITableView preview](https://github.com/FutureZhang/LXEmptyDataView/blob/master/SampleImage/1.png)

LXEmptyDataView作为UITableView的Section Footer(组头)或Section Header(组尾)使用

```
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView.lx_itemsCount == 0) {
        return self.tableView.frame.size.height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LXEmptyDataView *emptyDataView = [[LXEmptyDataView alloc] initWithFrame:self.tableView.frame];
    emptyDataView.image = [UIImage imageNamed:@"ic_empty_data"];
    emptyDataView.title = [NSAttributedString lx_attributedString:@"暂无数据" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
    emptyDataView.touchAllViewBlock = ^{
        //此处是点击整个View的操作
    };
    return emptyDataView;
}
```

### 2. UICollectionView使用

![UITableView preview](https://github.com/FutureZhang/LXEmptyDataView/blob/master/SampleImage/9.png)

LXEmptyDataView作为UICollectionView的Section Footer(组头)或Section Header(组尾)使用

```
//必须先注册LXEmptyDataView为UICollectionView的Section Footer(组头)或Section Header(组尾)
[self.collectionView registerClass:[LXEmptyDataView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([LXEmptyDataView class])];

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if ([collectionView lx_itemsCount] == 0) {
        return CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    LXEmptyDataView *emptyDataView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([LXEmptyDataView class]) forIndexPath:indexPath];
    [emptyDataView lx_reloadEmptyDataView];//清除重用池中缓存
    emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
    emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
    emptyDataView.buttonTitle = [NSAttributedString lx_attributedString:@"重新加载" color:UIColorFromRGBValue(0X1296db) font:LXSystemFont15];
    emptyDataView.buttonBorderColor = UIColorFromRGBValue(0X1296db);
    emptyDataView.touchButtonBlock = ^{
        //此处是点击按钮的操作
    };
    return emptyDataView;
}
```

### 3. UIView使用

![UITableView preview](https://github.com/FutureZhang/LXEmptyDataView/blob/master/SampleImage/7.png)

LXEmptyDataView作为一个单独的View使用

```
LXEmptyDataView *emptyDataView = [[LXEmptyDataView alloc] initWithFrame:self.view.frame];
[self.view addSubview:_emptyDataView];
emptyDataView.image = [UIImage imageNamed:@"ic_pay_success"];
emptyDataView.rightTitle = [NSAttributedString lx_attributedString:@"支付成功" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
```







