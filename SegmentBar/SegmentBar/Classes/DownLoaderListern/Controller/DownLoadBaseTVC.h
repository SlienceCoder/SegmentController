//
//  DownLoadBaseTVC.h
//  SegmentBar
//
//  Created by xpchina2003 on 2017/6/19.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UITableViewCell *(^GetCellBlock) (UITableView *tableView,NSIndexPath *indexPath);
typedef CGFloat (^GetHeightBlock) (id model);
typedef void (^BindBlock) (UITableViewCell *cell, id model);

@interface DownLoadBaseTVC : UITableViewController

- (void)setUpWithDataSource:(NSArray *)dataSource getCell:(GetCellBlock)cellBlock cellHeight:(GetHeightBlock)cellHeightBlock bind:(BindBlock)bindBlock;

@end
