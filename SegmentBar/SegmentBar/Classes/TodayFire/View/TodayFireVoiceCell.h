//
//  TodayFireVoiceCell.h
//  SegmentBar
//
//  Created by xpchina2003 on 2017/6/19.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadVoiceModel.h"

typedef NS_ENUM(NSUInteger, TodayFireVoiceCellState){
    TodayFireVoiceCellStateWaitDownLoad,
    TodayFireVoiceCellStateDownLoading,
    TodayFireVoiceCellStateDownLoaded
} ;

@interface TodayFireVoiceCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DownLoadVoiceModel *voiceModel;
@end
