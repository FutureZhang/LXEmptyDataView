//
//  LXEmptyDataViewController.m
//  LXEmptyDataView_Example
//
//  Created by 张莉祥 on 2018/1/31.
//  Copyright © 2018年 FutureZhang. All rights reserved.
//

#import "LXEmptyDataViewController.h"
#import <LXEmptyDataView/LXEmptyDataView.h>

// 十六进制颜色
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LXEmptyDataViewController ()
//1：暂无数据，2：加载失败，3：其他，4：其他，5：其他
@property (assign, nonatomic) NSInteger status;
@property (strong, nonatomic) LXEmptyDataView *emptyDataView;
@end

@implementation LXEmptyDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.status = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
    
    [self initEmptyDataView];
}

- (void)refresh{
    if (self.status == 1) {
        self.status = 2;
        [self initEmptyDataView];
        return;
    }
    if (self.status == 2) {
        self.status = 3;
        [self initEmptyDataView];
        return;
    }
    if (self.status == 3) {
        self.status = 4;
        [self initEmptyDataView];
        return;
    }
    if (self.status == 4) {
        self.status = 5;
        [self initEmptyDataView];
        return;
    }
    if (self.status == 5) {
        self.status = 1;
        [self initEmptyDataView];
        return;
    }
}

- (void)initEmptyDataView{
    
    __weak typeof (self)weakSelf = self;
    
    if (!_emptyDataView) {
        _emptyDataView = [[LXEmptyDataView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_emptyDataView];
    }
    [_emptyDataView lx_reloadEmptyDataView];
    if (self.status == 1) {
        _emptyDataView.image = [UIImage imageNamed:@"ic_empty_data"];
        _emptyDataView.title = [NSAttributedString lx_attributedString:@"暂无数据" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
    }
    if (self.status == 2) {
        _emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
        _emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
        _emptyDataView.detail = [NSAttributedString lx_attributedString:@"详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
    }
    if (self.status == 3) {
        _emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
        _emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
        _emptyDataView.detail = [NSAttributedString lx_attributedString:@"详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
        
        _emptyDataView.buttonTitle = [NSAttributedString lx_attributedString:@"重新加载" color:UIColorFromRGBValue(0X1296db) font:[UIFont systemFontOfSize:15.0]];
        _emptyDataView.buttonBgColor = [UIColor clearColor];
        _emptyDataView.buttonBorderColor = [UIColor clearColor];
        _emptyDataView.touchButtonBlock = ^{
            weakSelf.status = 4;
            [weakSelf refresh];
        };
    }
    if (self.status == 4) {
        _emptyDataView.image = [UIImage imageNamed:@"ic_pay_success"];
        _emptyDataView.right = [NSAttributedString lx_attributedString:@"支付成功" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
    }
    if (self.status == 5) {
        _emptyDataView.image = [UIImage imageNamed:@"ic_pay_success"];
        _emptyDataView.right = [NSAttributedString lx_attributedString:@"支付成功" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
        _emptyDataView.detail = [NSAttributedString lx_attributedString:@"详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述" color:[UIColor grayColor] font:[UIFont systemFontOfSize:15.0]];
        _emptyDataView.buttonTitle = [NSAttributedString lx_attributedString:@"点击返回" color:UIColorFromRGBValue(0X1296db) font:[UIFont systemFontOfSize:15.0]];
        _emptyDataView.buttonBorderColor = UIColorFromRGBValue(0X1296db);
        _emptyDataView.buttonCornerRadius = YES;
        _emptyDataView.touchButtonBlock = ^{
            weakSelf.status = 1;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    //点击整个View
    _emptyDataView.touchAllViewBlock = ^{
        [weakSelf refresh];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
