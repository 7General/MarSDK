//
//  SceneendTask.h
//  GZIMCustomService
//
//  Created by zzg on 2018/4/11.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "CGITask.h"
#import <Sceneend.pbobjc.h>

@interface SceneEndTask : CGITask

+ (instancetype)SceneEndWithSceneId:(NSString *)scenceId
                              appId:(NSString *)appId
                             chatId:(NSString *)chatId
                                 to:(NSString *)to
                           toDomain:(int32_t)toDomain
                               guid:(NSString *)guid
                            agentId:(NSString *)agentId
                          agentName:(NSString *)agentName
                          ext:(NSString *)ext
                            onResult:(void (^)(BOOL success, SceneEndSendResponse *response))result;

- (instancetype)initWithSceneId:(NSString *)scenceId
                          appId:(NSString *)appId
                         chatId:(NSString *)chatId
                             to:(NSString *)to
                       toDomain:(int32_t)toDomain
                           guid:(NSString *)guid
                        agentId:(NSString *)agentId
                      agentName:(NSString *)agentName
                            ext:(NSString *)ext
                    onResult:(void (^)(BOOL success, SceneEndSendResponse *response))result;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)ChannelType AndCmdId:(uint32_t)cmdId AndCGIUri:(NSString *)cgiUri AndHost:(NSString *)host NS_UNAVAILABLE;

@end
