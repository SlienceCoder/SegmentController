//
//  NoDownLoadView.h
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/28.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDownLoadView : UIView

+ (instancetype)noDownLoadView;

@property (nonatomic, strong) UIImage *noDataImg;

@property (nonatomic, copy) void(^clickBlock)();

@end
