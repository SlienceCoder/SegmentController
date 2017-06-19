//
//  SegmentBarConfig.h
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/31.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SegmentBarConfig : NSObject
+ (instancetype)defaultConfig;

// 背景颜色
@property (nonatomic, strong) UIColor *segmentBarBackColor;
@property (nonatomic, strong) UIColor *itemnormalColor;
@property (nonatomic, strong) UIColor *itemSelectedColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGFloat indicatorHeight;
@property (nonatomic, assign) CGFloat indicatorExtraW;

// 内部实现， 外界只负责调用
// 改变item常色和选中的颜色
@property (nonatomic, copy, readonly) SegmentBarConfig *(^itemNC)(UIColor *color);
@property (nonatomic, copy, readonly) SegmentBarConfig *(^itemSC) (UIColor *color);
@property (nonatomic, copy, readonly) SegmentBarConfig *(^indicatorEW)(CGFloat w);
    
@end
