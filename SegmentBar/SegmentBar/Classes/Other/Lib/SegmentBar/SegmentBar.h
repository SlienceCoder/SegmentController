//
//  SegmentBar.h
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/28.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SegmentBar : UIView


/**
 快速创建一个选项卡控件

 @param frame frame
 @return 选项卡控件

 */
+ (instancetype)segmentBarWithFrame:(CGRect)frame;

// 数据源
    @property (nonatomic, strong) NSArray <NSString *>*items;
    // 当前选中的索引
    @property (nonatomic, assign) NSInteger selectedIndex;
    
@end
