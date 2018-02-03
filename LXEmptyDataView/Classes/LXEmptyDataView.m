//
//  LXEmptyDataView.m
//  LXEmptyDataView
//
//  Created by 张莉祥 on 2018/1/15.
//  Copyright © 2018年 zhanglixiang. All rights reserved.
//

#import "LXEmptyDataView.h"

#define LX_Width self.frame.size.width
#define LX_Height self.frame.size.height
#define LX_VerticalOffset (self.frame.size.height/8)

static CGFloat const LX_LeftMargin = 10.0;
static CGFloat const LX_TopMargin  = 20.0;
static CGFloat const LX_ButtonHeight = 30.0;

@interface LXEmptyDataView()
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *rightLabel;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *detailLabel;
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIButton *rightButton;
@end

@implementation LXEmptyDataView

/**
 LXEmptyView 初始化
 @param frame 大小
 @return LXEmptyView
 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
        //LXEmptyView添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAllView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

/**
 imageView 初始化
 @return UIImageView
 */
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
    }
    return _imageView;
}

/**
 rightLabel 初始化
 @return UILabel
 */
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.font = [UIFont systemFontOfSize:15.0];
        _rightLabel.textColor = [UIColor grayColor];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
        _rightLabel.numberOfLines = 0;
        [self addSubview:_rightLabel];
    }
    return _rightLabel;
}

/**
 titleLabel 初始化
 @return UILabel
 */
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

/**
 detailLabel 初始化
 @return UILabel
 */
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = [UIFont systemFontOfSize:15.0];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.numberOfLines = 0;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}

/**
 button 初始化
 @return UIButton
 */
- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor clearColor];
        _button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _button.titleLabel.textColor = [UIColor grayColor];
        
        [_button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return _button;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor clearColor];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _rightButton.titleLabel.textColor = [UIColor grayColor];
        
        [_rightButton addTarget:self action:@selector(touchRightButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = _image;
    [self setSubViewsFrame];
}

- (void)setRightTitle:(NSAttributedString *)rightTitle{
    _rightTitle = rightTitle;
    self.rightLabel.attributedText = _rightTitle;
    [self setSubViewsFrame];
}

- (void)setTitle:(NSAttributedString *)title{
    _title = title;
    self.titleLabel.attributedText = _title;
    [self setSubViewsFrame];
}

- (void)setDetail:(NSAttributedString *)detail{
    _detail = detail;
    self.detailLabel.attributedText = _detail;
    [self setSubViewsFrame];
}

- (void)setButtonTitle:(NSAttributedString *)buttonTitle{
    _buttonTitle = buttonTitle;
    [self.button setAttributedTitle:_buttonTitle forState:UIControlStateNormal];
    [self setSubViewsFrame];
}

- (void)setRightButtonTitle:(NSAttributedString *)rightButtonTitle{
    _rightButtonTitle = rightButtonTitle;
    [self.rightButton setAttributedTitle:_rightButtonTitle forState:UIControlStateNormal];
    [self setSubViewsFrame];
}

- (void)setButtonBgColor:(UIColor *)buttonBgColor{
    _buttonBgColor = buttonBgColor;
    self.button.backgroundColor = _buttonBgColor;
    self.rightButton.backgroundColor = _buttonBgColor;
}

- (void)setButtonBorderColor:(UIColor *)buttonBorderColor{
    _buttonBorderColor = buttonBorderColor;
    self.button.layer.borderColor = _buttonBorderColor.CGColor;
    self.rightButton.layer.borderColor = _buttonBorderColor.CGColor;
    if (_buttonBorderColor) {
        self.button.layer.masksToBounds = YES;
        self.button.layer.borderWidth = 1;
        self.rightButton.layer.masksToBounds = YES;
        self.rightButton.layer.borderWidth = 1;
    }else{
        self.button.layer.masksToBounds = NO;
        self.button.layer.borderWidth = 0;
        self.rightButton.layer.masksToBounds = NO;
        self.rightButton.layer.borderWidth = 0;
    }
}

- (void)setButtonCornerRadius:(BOOL)buttonCornerRadius{
    _buttonCornerRadius = buttonCornerRadius;
    if (_buttonCornerRadius) {
        self.button.layer.cornerRadius = LX_ButtonHeight/2;
        self.rightButton.layer.cornerRadius = LX_ButtonHeight/2;
    }else{
        self.button.layer.cornerRadius = 0;
        self.rightButton.layer.cornerRadius = 0;
    }
}

/**
 UI 布局
 */
- (void)setSubViewsFrame{
    if (_image) {
        _imageView.frame = CGRectMake((_rightTitle.length>0?(LX_Width/2-_image.size.width):(LX_Width-_image.size.width)/2), LX_VerticalOffset, _image.size.width, _image.size.height);
    }
    
    if (_rightTitle) {
        if (_image) {
            _rightLabel.frame = CGRectMake(LX_Width/2 + LX_LeftMargin, _imageView.center.y-LX_ButtonHeight/2, LX_Width/2 - LX_LeftMargin*2, (_rightTitle.length>0?LX_ButtonHeight:0));
        }
    }
    
    if (_title) {
        CGFloat titleLabelHeight = _title.length>0?[_title lx_calculateTextHeightWithWidth:LX_Width-LX_LeftMargin*2]:0;
        _titleLabel.frame = CGRectMake(LX_LeftMargin, (_imageView.frame.size.height>0?(_imageView.frame.origin.y + _imageView.frame.size.height + LX_TopMargin):LX_VerticalOffset), LX_Width-LX_LeftMargin*2, titleLabelHeight);
    }
    
    if (_detail) {
        CGFloat detailLabelHeight = _detail.length>0?[_detail lx_calculateTextHeightWithWidth:LX_Width-LX_LeftMargin*2]:0;
        _detailLabel.frame = CGRectMake(LX_LeftMargin, (_imageView.frame.size.height>0?(_imageView.frame.origin.y + _imageView.frame.size.height + LX_TopMargin):LX_VerticalOffset) + (_titleLabel.frame.size.height>0?(_titleLabel.frame.size.height + LX_TopMargin):0), LX_Width-LX_LeftMargin*2, detailLabelHeight);
    }
    
    if (_buttonTitle) {
        CGFloat buttonWidth = [_buttonTitle lx_calculateTextWidthWithHeight:LX_ButtonHeight] + 40;
        if (buttonWidth > (LX_Width - LX_LeftMargin*2)) {
            buttonWidth = LX_Width - LX_LeftMargin*2;
        }
        if (_rightButtonTitle&&(buttonWidth > (LX_Width/2 - LX_LeftMargin*2))) {
            buttonWidth = LX_Width/2 - LX_LeftMargin*2;
        }
        _button.frame = CGRectMake(_rightButtonTitle?(LX_Width/2 - buttonWidth - LX_LeftMargin):(LX_Width - buttonWidth)/2, (_imageView.frame.size.height>0?(_imageView.frame.origin.y + _imageView.frame.size.height + LX_TopMargin):LX_VerticalOffset) + (_titleLabel.frame.size.height>0?(_titleLabel.frame.size.height + LX_TopMargin):0) + (_detailLabel.frame.size.height>0?(_detailLabel.frame.size.height + LX_TopMargin):0), buttonWidth, (_buttonTitle.length>0?LX_ButtonHeight:0));
    }
    
    if (_buttonTitle&&_rightButtonTitle) {
        CGFloat rightButtonWidth = [_rightButtonTitle lx_calculateTextWidthWithHeight:LX_ButtonHeight] + 40;
        if (rightButtonWidth > (LX_Width/2 - LX_LeftMargin*2)) {
            rightButtonWidth = LX_Width/2 - LX_LeftMargin*2;
        }
        _rightButton.frame = CGRectMake(LX_Width/2 + LX_LeftMargin, _button.frame.origin.y, rightButtonWidth, (_rightButtonTitle.length>0?LX_ButtonHeight:0));
    }
}

- (void)lx_reloadEmptyDataView{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _imageView = nil;
    _rightLabel = nil;
    _titleLabel = nil;
    _detailLabel = nil;
    _button = nil;
    _rightButton = nil;
    
    _image = nil;
    _rightTitle = nil;
    _title = nil;
    _detail = nil;
    _buttonTitle = nil;
    _rightButtonTitle = nil;
    _buttonBgColor = nil;
    _buttonBorderColor = nil;
    _buttonCornerRadius = NO;
}

/**
 LXEmptyDataView 点击事件
 */
- (void)touchAllView{
    if (_touchAllViewBlock) {
        _touchAllViewBlock();
    }
}

/**
 button 点击事件
 @param sender id
 */
- (void)touchButton:(id)sender{
    if (_touchButtonBlock) {
        _touchButtonBlock();
    }
}

/**
 rightButton 点击事件
 @param sender id
 */
- (void)touchRightButton:(id)sender{
    if (_touchRightButtonBlock) {
        _touchRightButtonBlock();
    }
}

@end


@implementation UITableView (LXEmptyTableView)

- (NSInteger)lx_itemsCount{
    NSInteger items = 0;
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;
    if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self];
    }
    if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        for (NSInteger section = 0; section < sections; section++) {
            items += [dataSource tableView:self numberOfRowsInSection:section];
        }
    }
    return items;
}

@end


@implementation UICollectionView (LXEmptyCollectionView)

- (NSInteger)lx_itemsCount{
    NSInteger items = 0;
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    id <UICollectionViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;
    if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [dataSource numberOfSectionsInCollectionView:self];
    }
    if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        for (NSInteger section = 0; section < sections; section++) {
            items += [dataSource collectionView:self numberOfItemsInSection:section];
        }
    }
    return items;
}

@end


@implementation NSAttributedString (LXAttributedStringWH)

- (CGFloat)lx_calculateTextHeightWithWidth:(CGFloat)width {
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine context:nil].size;
    CGFloat height = ceil(textSize.height);
    return height;
}

- (CGFloat)lx_calculateTextWidthWithHeight:(CGFloat)height {
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading context:nil].size;
    CGFloat width = ceil(textSize.width);
    return width;
}

+ (NSAttributedString*)lx_attributedString:(NSString*)string color:(UIColor*)color font:(UIFont*)font{
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
}
@end
