//
//  LogoutTask.h
//  GZIMClient
//
//  Created by zhouxueyun on 2017/5/19.
//  Copyright © 2017年 呱呱开放平台. All rights reserved.
//

#import "CGITask.h"

@interface LogoutTask : CGITask

+ (instancetype)taskWithUserId:(NSString *)uid andToken:(NSString *)token;
- (instancetype)initWithUserId:(NSString *)uid andToken:(NSString *)token;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)ChannelType AndCmdId:(uint32_t)cmdId AndCGIUri:(NSString *)cgiUri AndHost:(NSString *)host NS_UNAVAILABLE;

@end
