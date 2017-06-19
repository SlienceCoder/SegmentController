//
//  DownLoadingVoiceTVC.m
//  SegmentBar
//
//  Created by xpchina2003 on 2017/6/19.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "DownLoadingVoiceTVC.h"

@interface DownLoadingVoiceTVC ()

@end

@implementation DownLoadingVoiceTVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    [self setUpWithDataSource:@[@"a",@"s"] getCell:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        return cell;
    } cellHeight:^CGFloat(id model) {
        return 50;
    } bind:^(UITableViewCell *cell, id model) {
        cell.textLabel.text = model;
    }];
}




@end
