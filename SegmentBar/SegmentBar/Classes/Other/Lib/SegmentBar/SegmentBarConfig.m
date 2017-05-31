//
//  SegmentBarConfig.m
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/31.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "SegmentBarConfig.h"

@implementation SegmentBarConfig

    + (instancetype)defaultConfig
    {
        SegmentBarConfig *config = [[SegmentBarConfig alloc] init];
        config.segmentBarBackColor = [UIColor clearColor];
        config.itemFont = [UIFont systemFontOfSize:15.0];
        config.itemnormalColor = [UIColor lightGrayColor];
        config.itemSelectedColor = [UIColor redColor];
        
        config.indicatorColor = [UIColor redColor];
        config.indicatorHeight = 2;
        config.indicatorExtraW = 10;
        
        return config;
    }
    
    - (SegmentBarConfig *(^)(UIColor *))itemNC
    {
        return ^(UIColor *color){
            self.itemnormalColor = color;
            return self;
        };
    }
    
    - (SegmentBarConfig *(^)(UIColor *))itemSC
    {
        return ^(UIColor *color) {
            self.itemSelectedColor = color;
            return self;
        };
    }
    - (SegmentBarConfig *(^)(CGFloat))indicatorEW
    {
        return ^(CGFloat w){
            self.indicatorExtraW = w;
            return self;
        };
    }
    
@end
