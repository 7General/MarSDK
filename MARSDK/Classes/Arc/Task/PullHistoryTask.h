//
//  PullHistoryTask.h
//  GZIMClient
//
//  Created by zhouxueyun on 2017/8/1.
//  Copyright © 2017年 呱呱开放平台. All rights reserved.
//

#import "CGITask.h"
#import <History.pbobjc.h>

@interface PullHistoryTask : CGITask

+ (instancetype)taskWithUserId:(NSString *)uid
                        domain:(int32_t)domain
                        chatId:(NSString *)chatId
                         appId:(NSString *)appId
                       sceneId:(NSString *)sceneId
                        offset:(int64_t)offset
                         count:(int32_t)count
                         logId:(NSString *)logId
                      onResult:(void (^)(BOOL success, PullHistoryResponse *response))result;

- (instancetype)initWithUserId:(NSString *)uid
                        domain:(int32_t)domain
                        chatId:(NSString *)chatId
                         appId:(NSString *)appId
                       sceneId:(NSString *)sceneId
                        offset:(int64_t)offset
                         count:(int32_t)count
                         logId:(NSString *)logId
                      onResult:(void (^)(BOOL success, PullHistoryResponse *response))result;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)ChannelType AndCmdId:(uint32_t)cmdId AndCGIUri:(NSString *)cgiUri AndHost:(NSString *)host NS_UNAVAILABLE;

@end
