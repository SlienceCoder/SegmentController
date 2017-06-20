//
//  DownLoaderManager.h
//  文件下载测试
//
//  Created by 郭吉刚 on 17/5/8.
//  Copyright © 2017年 GJG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownLoader.h"

@interface DownLoaderManager : NSObject
// 单利
+ (instancetype)shareManager;

// 根据URL下载
- (DownLoader *)downLoadWithURL:(NSURL *)url;

// 获取URL对应的downLoader
- (DownLoader *)getDownLoaderWithURL:(NSURL *)url;
// 根据URL下载资源
// 监听下载信息, 成功, 失败回调
- (void)downLoader:(NSURL *)url downLoadInfo:(DownLoadInfoType)downloadInfo progress:(ProgressBlockType)progress success:(SuccessBlock)success faild:(FaildBlock)faild;
// 根据URL暂停资源
- (void)pauseWithURL:(NSURL *)url;
- (void)resumeWithURL:(NSURL *)url;
- (void)cancelWithURL:(NSURL *)url;

// 暂停所有
- (void)pauseAll;
// 恢复所有
- (void)resumeAll;
@end
