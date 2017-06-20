//
//  TodayFireVoiceListTVC.m
//  SegmentBar
//
//  Created by xpchina2003 on 2017/6/19.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "TodayFireVoiceListTVC.h"

#import "SessionManager.h"
#import <MJExtension/MJExtension.h>
#import "DownLoadVoiceModel.h"

#import "TodayFireVoiceCell.h"

#define kBaseUrl @"http://mobile.ximalaya.com/"

@interface TodayFireVoiceListTVC ()
@property (nonatomic, strong) NSArray<DownLoadVoiceModel *> *voiceMs;

@property (nonatomic, strong) SessionManager *sessionManager;
@end

@implementation TodayFireVoiceListTVC

- (void)setVoiceMs:(NSArray<DownLoadVoiceModel *> *)voiceMs
{
    _voiceMs = voiceMs;
    [self.tableView reloadData];
}

- (SessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[SessionManager alloc] init];
    }
    return _sessionManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    
    [self loadData];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": self.loadKey,
                            @"pageId": @"1",
                            @"pageSize": @"30"
                            };
    
    [self.sessionManager request:RequestTypeGet url:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        NSMutableArray <DownLoadVoiceModel *>*voiceyMs = [DownLoadVoiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        weakSelf.voiceMs = voiceyMs;

    }];
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.voiceMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodayFireVoiceCell *cell = [TodayFireVoiceCell cellWithTableView:tableView];
    
    DownLoadVoiceModel *model = self.voiceMs[indexPath.row];
    model.sortNum = indexPath.row + 1;
    
    cell.voiceModel = model;
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DownLoadVoiceModel *model = self.voiceMs[indexPath.row];
    
    NSLog(@"跳转到播放器界面进行播放--%@--", model.title);
    
}



@end
