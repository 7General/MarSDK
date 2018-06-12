// Tencent is pleased to support the open source community by making GAutomator available.
// Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.

// Licensed under the MIT License (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://opensource.org/licenses/MIT

// Unless required by applicable law or agreed to in writing, software distributed under the License is
// distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied. See the License for the specific language governing permissions and
// limitations under the License.

#import <Foundation/Foundation.h>
#import "Messagecmd.pbobjc.h"
#import "AuthTask.h"
#import "PullHistoryTask.h"
#import "SyncTask.h"
#import "C2AiTask.h"
#import "C2KfTask.h"
#import "DistributionTask.h"


/// object is integer enum (GZIMLongLinkStatus)
FOUNDATION_EXPORT NSString * const kGZCSLongLinkStatusObserverName;
FOUNDATION_EXPORT NSString * const kGZCSLongLinkStatus;

typedef NS_ENUM(NSInteger, GZCSLongLinkStatus){
    GZCSLongLinkStatusConnected,
    GZCSLongLinkStatusConnecting,
    GZCSLongLinkStatusDisconnected,
};

@protocol GZCSLongLinkPushDelegate <NSObject>
@optional
- (void)longlinkPushMessage:(NSData*)pushData withCmdId:(int)cmdId;
@end

@protocol GZCSLongLinkAuthDelegate <NSObject>
@optional
- (BOOL)longLinkAuthed;
- (BOOL)longLinkAuthRequestWithUid:(NSString **)uid token:(NSString **)token domain:(int32_t *)domain guid:(NSString **)guid;
- (BOOL)longlinkAuthResponseWithStatus:(int32_t)status errCode:(int32_t)code errMsg:(NSString *)msg;
@end

@protocol GZCSLongLinkContectDelegate <NSObject>
@optional - (void)longlinkContectStatusDidChanged:(GZCSLongLinkStatus)status;
@end

@class CGITask;
@interface GZCSLongLink : NSObject

// 是为了解耦，在GZCSLongLink 创建时初始化appID，和ipList，防止引用相关的类文件，导致pod私有库不能解耦
@property(nonatomic,copy) NSString *appID;
@property(nonatomic,strong) NSArray *ipList;


- (void)OnConnectionStatusChange:(int)status longConnStatus:(int)longConnStatus;
- (void)OnPushWithCmd:(int)cmdId data:(NSData *)data;
- (NSArray *)ipListForLonglink;

- (NSData*)Request2BufferWithTaskID:(uint32_t)tid userContext:(const void *)context;
- (int)Buffer2ResponseWithTaskID:(uint32_t)tid ResponseData:(NSData *)data userContext:(const void *)context;
- (int)OnTaskEndWithTaskID:(uint32_t)tid userContext:(const void *)context errType:(int)errtype errCode:(int)errcode;

- (BOOL)isAuthed;
- (CmdID)authCmdId;
- (NSData*)authRequestData;
- (BOOL)authResponseData:(NSData*)responseData;

@property (nonatomic, weak) id<GZCSLongLinkAuthDelegate> authDelegate;
@property (nonatomic, weak) id<GZCSLongLinkContectDelegate> connectDelegate;

+ (instancetype)sharedLongLink;

- (void)addLongLinkPushObserver:(id<GZCSLongLinkPushDelegate>)observer withCmdId:(CmdID)cmdId;

#pragma mark - Public
- (void)createLongLinkWithAddress:(NSString *)addr ports:(NSArray *)ports clientVersion:(uint32_t)version;
- (void)destoryLongLink;
- (void)reSetLongLink;

- (void)makesureLongLinkConnect;
- (BOOL)longLinkIsConnected;

- (void)reportOnForegroud:(BOOL)foreground;

- (uint32_t)nextTaskId;
- (uint32_t)startTask:(CGITask*)task;

#pragma mark - Bussiness
- (uint32_t)startAuthWithUserId:(NSString *)uid
                          token:(NSString *)token
                            guid:(NSString *)guid
                          appid:(NSString *)appid
                         domain:(int32_t)domain
                       onResult:(void(^)(BOOL success, AuthResponse *response))result;

- (uint32_t)startLogoutWithUserId:(NSString *)uid
                            token:(NSString *)token;



- (uint32_t)startPullHistoryWithUserId:(NSString *)uid
                                domain:(int32_t)domain
                                chatId:(NSString *)chatId
                                 appId:(NSString *)appId
                               sceneId:(NSString *)sceneId
                                offset:(int64_t)offset
                                 limit:(int32_t)limit
                                 logId:(NSString *)logId
                              onResult:(void (^)(BOOL, PullHistoryResponse *))result;


/* sync同步 */
- (uint32_t)startSyncWithUid:(NSString *)uid
                      domain:(int32_t)domain
                      offset:(int64_t)offset
                       limit:(int32_t)limit
                       logId:(NSString *)logId
                       appId:(NSString *)appId
                    onResult:(void (^)(BOOL success, SyncResponse *response))result;

/* C2AI */
- (uint32_t)startC2AiWithFrom:(NSString *)from
                     fromName:(NSString *)fromName
                   fromDomain:(int32_t)fromDomain
                         guid:(NSString *)guid
                       chatId:(NSString *)chatId
                      sceneId:(NSString *)sceneId
                      content:(NSString *)content
                         type:(int32_t)type
                        appId:(NSString *)appId
                          ext:(NSString *)ext
                     onResult:(void (^)(BOOL success, C2AiResponse *response))result;

/* C2KF */
- (uint32_t)startC2KfWithFrom:(NSString *)from
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

/* 坐席分配 */
- (uint32_t)startDistributeWithFrom:(NSString *)from
                                        fromDomain:(int32_t)fromDomain
                                        guid:(NSString *)guid
                                        sceneId:(NSString *)sceneId
                                        content:(NSString *)content
                                        type:(int32_t)type
                                        appId:(NSString *)appId
                             chatId:(NSString *)chatId
                                ext:(NSString *)ext
                           onResult:(void (^)(BOOL success, DistributeResponse *response))result;



@end

