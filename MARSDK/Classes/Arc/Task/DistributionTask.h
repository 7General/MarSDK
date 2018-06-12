//
//  Distribution.h
//  GZIMCustomService
//
//  Created by zzg on 2018/4/11.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "CGITask.h"
#import <Distribute.pbobjc.h>

@interface DistributionTask : CGITask

+ (instancetype)DistributionWithFrom:(NSString *)from
                          fromDomain:(int32_t)fromDomain
                                guid:(NSString *)guid
                             sceneId:(NSString *)sceneId
                             content:(NSString *)content
                                type:(int32_t)type
                               appId:(NSString *)appId
                                chatId:(NSString *)chatId
                                ext:(NSString *)ext
                    onResult:(void (^)(BOOL success, DistributeResponse *response))result;

- (instancetype)initWithFrom:(NSString *)from
                  fromDomain:(int32_t)fromDomain
                        guid:(NSString *)guid
                     sceneId:(NSString *)sceneId
                     content:(NSString *)content
                        type:(int32_t)type
                       appId:(NSString *)appId
                      chatId:(NSString *)chatId
                         ext:(NSString *)ext
                    onResult:(void (^)(BOOL success, DistributeResponse *response))result;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)ChannelType AndCmdId:(uint32_t)cmdId AndCGIUri:(NSString *)cgiUri AndHost:(NSString *)host NS_UNAVAILABLE;

@end
