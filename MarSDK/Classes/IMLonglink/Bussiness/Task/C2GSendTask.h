//
//  C2GSendTask.h
//  GZIMClient
//
//  Created by zhouxueyun on 2017/4/26.
//  Copyright © 2017年 呱呱开放平台. All rights reserved.
//

#import "CGITask.h"
#import "C2Gsend.pbobjc.h"

@interface C2GSendTask : CGITask

+ (instancetype)taskWithFrom:(NSString *)from fromName:(NSString *)fromName group:(NSString *)group content:(NSString *)content type:(int32_t)type onResult:(void (^)(BOOL success, C2GSendResponse *response))result;
- (instancetype)initWithFrom:(NSString *)from fromName:(NSString *)fromName group:(NSString *)group content:(NSString *)content type:(int32_t)type onResult:(void (^)(BOOL success, C2GSendResponse *response))result;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)ChannelType AndCmdId:(uint32_t)cmdId AndCGIUri:(NSString *)cgiUri AndHost:(NSString *)host NS_UNAVAILABLE;

@end
