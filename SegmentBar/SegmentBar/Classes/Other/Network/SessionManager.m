//
//  SessionManager.m
//  SegmentBar
//
//  Created by xpchina2003 on 2017/6/19.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "SessionManager.h"
#import <AFNetworking/AFNetworking.h>

@interface SessionManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionmanager;

@end

@implementation SessionManager
- (void)setValue:(NSString *)value forHttpField:(NSString *)filed
{
    [self.sessionmanager.requestSerializer setValue:value forHTTPHeaderField:filed];
}

- (AFHTTPSessionManager *)sessionmanager
{
    if (!_sessionmanager) {
        _sessionmanager = [AFHTTPSessionManager manager];
        NSMutableSet *setM = [_sessionmanager.responseSerializer.acceptableContentTypes mutableCopy];
        [setM addObject:@"text/plain"];
        [setM addObject:@"text/html"];
        _sessionmanager.responseSerializer.acceptableContentTypes = [setM copy];
    }
    return _sessionmanager;
}

- (void)request:(RequestType)type url:(NSString *)url parameter:(NSDictionary *)param resultBlock:(void(^)(id responseObject,NSError *error))resultBlock
{
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultBlock(responseObject, nil);
    };
    
    void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil, error);
    };
    
    if (type == RequestTypeGet) {
        [self.sessionmanager GET:url parameters:param progress:nil success:successBlock failure:failBlock];
    } else {
        [self.sessionmanager POST:url parameters:param progress:nil success:successBlock failure:failBlock];
    }

}
@end
