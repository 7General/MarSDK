//
//  SyncTask.h
//  GZIMCustomService
//
//  Created by zzg on 2018/3/29.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "CGITask.h"
#import <Sync.pbobjc.h>

@interface SyncTask : CGITask
+ (instancetype)syncWithUid:(NSString *)uid
                     domain:(int32_t)domain
                     offset:(int64_t)offset
                      limit:(int32_t)limit
                      logId:(NSString *)logId
                      appId:(NSString *)appId
                   onResult:(void (^)(BOOL success, SyncResponse *response))result;

- (instancetype)initWithUid:(NSString *)uid
                     domain:(int32_t)domain
                     offset:(int64_t)offset
                      limit:(int32_t)limit
                      logId:(NSString *)logId
                      appId:(NSString *)appId
                   onResult:(void (^)(BOOL success, SyncResponse *response))result;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)ChannelType AndCmdId:(uint32_t)cmdId AndCGIUri:(NSString *)cgiUri AndHost:(NSString *)host NS_UNAVAILABLE;
@end
