//
//  DownLoadBaseTVC.m
//  SegmentBar
//
//  Created by xpchina2003 on 2017/6/19.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "DownLoadBaseTVC.h"
#import "NoDownLoadView.h"
#import "TodayFireMainVC.h"

@interface DownLoadBaseTVC ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) NoDownLoadView *nodataLoadView;

@property (nonatomic, copy) GetCellBlock cellBlock;
@property (nonatomic, copy) GetHeightBlock heightBlock;
@property (nonatomic, copy) BindBlock bindBlock;

@end

@implementation DownLoadBaseTVC

- (NoDownLoadView *)nodataLoadView
{
    if (!_nodataLoadView) {
        NoDownLoadView *noloadView = [NoDownLoadView noDownLoadView];
        [self.view addSubview:noloadView];
        _nodataLoadView = noloadView;
    }
    return _nodataLoadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.nodataLoadView.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.4);
    
    if ([self isKindOfClass:NSClassFromString(@"XMGDownLoadingVoiceTVC")]) {
        self.nodataLoadView.noDataImg = [UIImage imageNamed:@"noData_downloading"];
    }else {
        self.nodataLoadView.noDataImg = [UIImage imageNamed:@"noData_download"];
    }
    
    [self.nodataLoadView setClickBlock:^{
        TodayFireMainVC *vc = [[TodayFireMainVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];

}


- (void)setUpWithDataSource:(NSArray *)dataSource getCell:(GetCellBlock)cellBlock cellHeight:(GetHeightBlock)cellHeightBlock bind:(BindBlock)bindBlock
{
    self.dataSource = dataSource;
    self.cellBlock = cellBlock;
    self.heightBlock = cellHeightBlock;
    self.bindBlock = bindBlock;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.nodataLoadView.hidden = self.dataSource.count != 0;
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    UITableViewCell *cell = self.cellBlock(tableView,indexPath);
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataSource[indexPath.row];
    self.bindBlock(cell, model);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataSource[indexPath.row];
    if (self.heightBlock) {
        return  self.heightBlock(model);
    }
    return 44;
}


@end
