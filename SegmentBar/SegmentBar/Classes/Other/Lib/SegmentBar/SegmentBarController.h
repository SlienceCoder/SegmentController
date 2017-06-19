//
//  SegmentBarController.h
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/31.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentBar.h"

@interface SegmentBarController : UIViewController
@property (nonatomic, weak) SegmentBar *segmentBar;

- (void)setUpWithItems:(NSArray <NSString *>*)items childvcs:(NSArray <UIViewController *>*)vcArr;
@end
