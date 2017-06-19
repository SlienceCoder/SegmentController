//
//  SessionManager.h
//  SegmentBar
//
//  Created by xpchina2003 on 2017/6/19.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost
};

@interface SessionManager : NSObject

- (void)setValue:(NSString *)value forHttpField:(NSString *)filed;

- (void)request:(RequestType)type url:(NSString *)url parameter:(NSDictionary *)param resultBlock:(void(^)(id responseObject,NSError *error))resultBlock;

@end
