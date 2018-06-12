//
//  C2KfTask.h
//  GZIMCustomService
//
//  Created by zzg on 2018/4/11.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "CGITask.h"
#import <C2Kf.pbobjc.h>

@interface C2KfTask : CGITask

+ (instancetype)C2KfWithFrom:(NSString *)from
                    fromName:(NSString *)fromName
                  fromDomain:(int32_t)fromDomain
                        guid:(NSString *)guid
                      chatId:(NSString *)chatId
                     sceneId:(NSString *)sceneId
                     content:(NSString *)content
                        type:(int32_t)type
                       appId:(NSString *)appId
                         ext:(NSString *)ext
                    onResult:(void (^)(BOOL success, C2KfResponse *response))result;

- (instancetype)initWithFrom:(NSString *)from
                    fromName:(NSString *)fromName
                  fromDomain:(int32_t)fromDomain
                        guid:(NSString *)guid
                      chatId:(NSString *)chatId
                     sceneId:(NSString *)sceneId
                     content:(NSString *)content
                        type:(int32_t)type
                       appId:(NSString *)appId
                         ext:(NSString *)ext
                    onResult:(void (^)(BOOL success, C2KfResponse *response))result;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId NS_UNAVAILABLE;
- (instancetype)initAll:(ChannelType)ChannelType AndCmdId:(uint32_t)cmdId AndCGIUri:(NSString *)cgiUri AndHost:(NSString *)host NS_UNAVAILABLE;

@end
