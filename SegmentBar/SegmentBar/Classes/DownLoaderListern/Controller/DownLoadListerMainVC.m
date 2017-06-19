//
//  DownLoadListerMainVC.m
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/28.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "DownLoadListerMainVC.h"
#import "SegmentBarController.h"

@interface DownLoadListerMainVC ()
@property (nonatomic, weak) SegmentBarController *segmentBarVC;
@end

@implementation DownLoadListerMainVC

#pragma mark --懒加载
- (SegmentBarController *)segmentBarVC
{
    if (!_segmentBarVC) {
        SegmentBarController *vc = [[SegmentBarController alloc] init];
        [self addChildViewController:vc];
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setUpUI];
    [self setUpDataSource];
    
}

/**
 绘制界面
 */
- (void)setUpUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1. 设置导航栏背景颜色, 以及titleView内容视图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_64"] forBarMetrics:UIBarMetricsDefault];
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 300, 40);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    // 2. 设置控制器内容视图
    self.segmentBarVC.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    [self.view addSubview:self.segmentBarVC.view];

}

/**
 显示控制器数据源
 */
- (void)setUpDataSource
{
    UITableViewController *vc1 = [[UITableViewController alloc] init];
    vc1.view.backgroundColor = [UIColor purpleColor];
    UITableViewController *vc2 = [[UITableViewController alloc] init];
    UITableViewController *vc3 = [[UITableViewController alloc] init];
    vc3.view.backgroundColor = [UIColor lightGrayColor];
    [self.segmentBarVC setUpWithItems:@[@"专辑", @"声音", @"下载中"] childvcs:@[vc1, vc2, vc3]];
    
    [self.segmentBarVC.segmentBar updateWithConfig:^(SegmentBarConfig *config) {
        config.segmentBarBackColor = [UIColor whiteColor];
    }];
}



@end
