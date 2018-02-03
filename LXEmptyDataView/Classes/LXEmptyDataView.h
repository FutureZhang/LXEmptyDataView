//
//  LXEmptyDataView.h
//  LXEmptyDataView
//
//  Created by 张莉祥 on 2018/1/15.
//  Copyright © 2018年 zhanglixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^LXTouchButtonBlock)(void);
typedef void(^LXTouchRightButtonBlock)(void);
typedef void(^LXTouchAllViewBlock)(void);

@interface LXEmptyDataView : UICollectionReusableView
//imageView图片
@property(nonatomic, strong) UIImage *image;
//rightLabel文字内容
@property(nonatomic, strong) NSAttributedString *rightTitle;
//titleLabel文字内容
@property(nonatomic, strong) NSAttributedString *title;
//detailLabel文字内容
@property(nonatomic, strong) NSAttributedString *detail;
//button文字内容
@property(nonatomic, strong) NSAttributedString *buttonTitle;
//rightButton文字内容
@property(nonatomic, strong) NSAttributedString *rightButtonTitle;
//button背景颜色
@property(nonatomic, strong) UIColor *buttonBgColor;
//button是否设置圆角
@property(nonatomic, assign) BOOL buttonCornerRadius;
//button设置圆角
@property(nonatomic, strong) UIColor *buttonBorderColor;
//button点击事件block
@property(nonatomic, copy) LXTouchButtonBlock touchButtonBlock;
//rightButton点击事件block
@property(nonatomic, copy) LXTouchRightButtonBlock touchRightButtonBlock;
//整个LXEmptyDataView点击事件block
@property(nonatomic, copy) LXTouchAllViewBlock touchAllViewBlock;
/**
 重置子控件
 */
- (void)lx_reloadEmptyDataView;
@end


@interface UITableView (LXEmptyDataView)
/**
 UITableView cell 的个数
 */
- (NSInteger)lx_itemsCount;
@end


@interface UICollectionView (LXEmptyDataView)
/**
 UICollectionView item 的个数
 */
- (NSInteger)lx_itemsCount;
@end


@interface NSAttributedString (LXEmptyDataView)
/**
 计算一定宽度和字体的文本的高
 @param width 文本的宽度
 @return height
 */
- (CGFloat)lx_calculateTextHeightWithWidth:(CGFloat)width;
/**
 计算一定高度和字体的文本的宽
 @param height 文本的高度
 @return width
 */
- (CGFloat)lx_calculateTextWidthWithHeight:(CGFloat)height;
/**
 string转换为NSAttributedString
 @param string NSString
 @param color UIColor
 @param font UIFont
 @return NSAttributedString
 */
+ (NSAttributedString*)lx_attributedString:(NSString*)string color:(UIColor*)color font:(UIFont*)font;
@end


