//
//  SegmentBar.h
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/28.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentBarConfig.h"


@class SegmentBar;
@protocol SegmentBarDelegate <NSObject>

/**
 代理方法，告诉外界，内部点击事件

 @param segmentBar segmentBar
 @param toIndex toIndex(选中的索引 )
 @param fromIndex fromIndex（下一个索引）
 */
- (void)segmentBar:(SegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

@interface SegmentBar : UIView


/**
 快速创建一个选项卡控件

 @param frame frame
 @return 选项卡控件

 */
+ (instancetype)segmentBarWithFrame:(CGRect)frame;

@property (nonatomic, weak) id<SegmentBarDelegate> delegate;

// 数据源
@property (nonatomic, strong) NSArray <NSString *>*items;
// 当前选中的索引
@property (nonatomic, assign) NSInteger selectedIndex;

- (void)updateWithConfig:(void(^)(SegmentBarConfig *config))configBlock;
    
@end
