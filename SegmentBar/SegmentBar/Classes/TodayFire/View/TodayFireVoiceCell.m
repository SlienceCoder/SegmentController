//
//  TodayFireVoiceCell.m
//  SegmentBar
//
//  Created by xpchina2003 on 2017/6/19.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "TodayFireVoiceCell.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "DownLoaderManager.h"

@interface TodayFireVoiceCell ()
@property (weak, nonatomic) IBOutlet UILabel *sortNumLab;
@property (weak, nonatomic) IBOutlet UIButton *palyOrPauseBtn;
@property (weak, nonatomic) IBOutlet UILabel *voiceTitle;
@property (weak, nonatomic) IBOutlet UILabel *anthorTitle;
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;

@property (nonatomic, assign) TodayFireVoiceCellState state;
@end

@implementation TodayFireVoiceCell

static NSString *const ID = @"TodayFireVoiceCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    TodayFireVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TodayFireVoiceCell" owner:nil options:nil] firstObject];
        [cell addObserver:cell forKeyPath:@"sortNumLab.text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return cell;
}


- (IBAction)playOrPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    NSLog(@"播放/暂停");

}


- (void)setState:(TodayFireVoiceCellState)state
{
    _state = state;
    switch (state) {
        case TodayFireVoiceCellStateWaitDownLoad:
            NSLog(@"等待下载");
            [self removeRotationAnimation];
            [self.downLoadBtn setImage:[UIImage imageNamed:@"cell_download"] forState:UIControlStateNormal];
            break;
        case TodayFireVoiceCellStateDownLoading:
            NSLog(@"正在下载");
            [self.downLoadBtn setImage:[UIImage imageNamed:@"cell_download_loading"] forState:UIControlStateNormal];
            [self addRotationAnimation];
            break;
        case TodayFireVoiceCellStateDownLoaded:
            NSLog(@"下载完毕");
            [self removeRotationAnimation];
            [self.downLoadBtn setImage:[UIImage imageNamed:@"cell_downloaded"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    
}

- (void)setVoiceModel:(DownLoadVoiceModel *)voiceModel
{
    _voiceModel = voiceModel;
    
    self.voiceTitle.text = voiceModel.title;
    self.anthorTitle.text = [NSString stringWithFormat:@"by %@",voiceModel.nickname];
    
    [self.palyOrPauseBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:voiceModel.coverSmall] forState:UIControlStateNormal];
    self.sortNumLab.text = [NSString stringWithFormat:@"%zd",voiceModel.sortNum];
    
    
    
    // 一定要注意动态的获取下载状态
    // 因为cell重用, 所以必须准确的获取url对应的下载状态
    NSURL *url = [NSURL URLWithString:self.voiceModel.playPathAacv164];
    DownLoader *downLoader = [[DownLoaderManager shareManager] getDownLoaderWithURL:url];
    DownLoadState state = downLoader.states;

    if (state == DownLoadStateDownLoading) {
        self.state = TodayFireVoiceCellStateDownLoading;
    }else if(state == DownLoadStateSuccess || [DownLoader downLoadedFileWithURL:url].length > 0)
    {
        self.state = TodayFireVoiceCellStateDownLoaded;
    }else {
        self.state = TodayFireVoiceCellStateWaitDownLoad;
    }

    
}

- (void)addRotationAnimation
{
    [self removeRotationAnimation];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2.0);
    animation.duration = 10;
    animation.removedOnCompletion = NO;
    animation.repeatCount = MAXFLOAT;
    [self.downLoadBtn.imageView.layer addAnimation:animation forKey:@"rotation"];
}

- (void)removeRotationAnimation
{
    [self.downLoadBtn.imageView.layer removeAllAnimations];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"sortNumLab.text"];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.palyOrPauseBtn.layer.masksToBounds = YES;
    self.palyOrPauseBtn.layer.borderWidth = 3;
    self.palyOrPauseBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.palyOrPauseBtn.layer.cornerRadius = 20;
    
    // . 添加监听下载状态的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:kDownLoadURLOrStateChangeNotification object:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"sortNumLab.text"]) {
        NSInteger sort = [change[NSKeyValueChangeNewKey] integerValue];
        if (sort == 1) {
            self.sortNumLab.textColor = [UIColor redColor];
        }else if (sort == 2) {
            self.sortNumLab.textColor = [UIColor orangeColor];
        }else if (sort == 3) {
            self.sortNumLab.textColor = [UIColor greenColor];
        }else {
            self.sortNumLab.textColor = [UIColor grayColor];
        }
        return;
        
    }

}


#pragma mark --下载功能集成
// 当用户点击下载按钮时, 触发的动作, 注意判断按钮当前状态
- (IBAction)downLoad:(id)sender {
    if (self.state == TodayFireVoiceCellStateWaitDownLoad) {
        NSLog(@"下载");
        
        NSURL *url = [NSURL URLWithString:self.voiceModel.playPathAacv164];
        [[DownLoaderManager shareManager] downLoadWithURL:url];
        
    }
}

// 下载状态变更时候调用
- (void)downLoadStateChange:(NSNotification *)notice
{
    NSDictionary *downDic = notice.userInfo;
    NSURL *url = downDic[@"downLoadURL"];
    
    NSURL *currentUrl = [NSURL URLWithString:self.voiceModel.playPathAacv164];
    
    if ([url isEqual:currentUrl]) {
        DownLoadState state = [downDic[@"downLoadState"] integerValue];
        
        if (state == DownLoadStateDownLoading) {
            self.state = TodayFireVoiceCellStateDownLoading;
        }else if(state == DownLoadStateSuccess || [DownLoader downLoadedFileWithURL:url].length > 0)
        {
            self.state = TodayFireVoiceCellStateDownLoaded;
        }else {
            self.state = TodayFireVoiceCellStateWaitDownLoad;
        }
    }

}


@end
