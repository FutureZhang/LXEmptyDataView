//
//  LXConstant.h
//  LXEmptyDataView
//
//  Created by 张莉祥 on 2018/2/3.
//  Copyright © 2018年 FutureZhang. All rights reserved.
//

#ifndef LXConstant_h
#define LXConstant_h

// 十六进制颜色
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//0X1296db 浅蓝色 UIColorFromRGBValue(0X1296db)
//0Xcccccc 浅灰色 UIColorFromRGBValue(0Xcccccc)

#define LXSystemFont15 [UIFont systemFontOfSize:15.0]


#endif /* LXConstant_h */
