//
//  LXEmptyDataViewController.m
//  LXEmptyDataView_Example
//
//  Created by 张莉祥 on 2018/1/31.
//  Copyright © 2018年 FutureZhang. All rights reserved.
//

#import "LXEmptyDataViewController.h"
#import <LXEmptyDataView/LXEmptyDataView.h>

@interface LXEmptyDataViewController ()
//1：暂无数据，2：加载失败，3：其他，4：其他，5：其他
@property (assign, nonatomic) NSInteger status;
@property (strong, nonatomic) LXEmptyDataView *emptyDataView;
@end

@implementation LXEmptyDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"UIView";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
    
    self.status = 1;
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
        _emptyDataView.title = [NSAttributedString lx_attributedString:@"暂无数据" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
    }
    if (self.status == 2) {
        _emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
        _emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
        _emptyDataView.detail = [NSAttributedString lx_attributedString:@"详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
    }
    if (self.status == 3) {
        _emptyDataView.image = [UIImage imageNamed:@"ic_loading_error"];
        _emptyDataView.title = [NSAttributedString lx_attributedString:@"加载失败" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
        _emptyDataView.detail = [NSAttributedString lx_attributedString:@"详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
        _emptyDataView.buttonTitle = [NSAttributedString lx_attributedString:@"重新加载" color:UIColorFromRGBValue(0X1296db) font:LXSystemFont15];
        _emptyDataView.buttonBorderColor = UIColorFromRGBValue(0X1296db);
        _emptyDataView.buttonCornerRadius = YES;
        _emptyDataView.touchButtonBlock = ^{
            [weakSelf refresh];
        };
    }
    if (self.status == 4) {
        _emptyDataView.image = [UIImage imageNamed:@"ic_pay_success"];
        _emptyDataView.rightTitle = [NSAttributedString lx_attributedString:@"支付成功" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
    }
    if (self.status == 5) {
        _emptyDataView.image = [UIImage imageNamed:@"ic_pay_failure"];
        _emptyDataView.rightTitle = [NSAttributedString lx_attributedString:@"支付失败" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
        _emptyDataView.detail = [NSAttributedString lx_attributedString:@"详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述-详细描述" color:UIColorFromRGBValue(0Xcccccc) font:LXSystemFont15];
        _emptyDataView.buttonTitle = [NSAttributedString lx_attributedString:@"点击返回" color:UIColorFromRGBValue(0X1296db) font:LXSystemFont15];
        _emptyDataView.touchButtonBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _emptyDataView.rightButtonTitle = [NSAttributedString lx_attributedString:@"重新支付" color:UIColorFromRGBValue(0X1296db) font:LXSystemFont15];
        _emptyDataView.touchRightButtonBlock = ^{
            [weakSelf refresh];
        };
        _emptyDataView.buttonBorderColor = UIColorFromRGBValue(0X1296db);
        _emptyDataView.buttonCornerRadius = YES;
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
