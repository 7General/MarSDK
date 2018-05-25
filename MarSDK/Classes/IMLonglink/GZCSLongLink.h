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

typedef NS_ENUM(int32_t,CmdID) {
    /** 登录 */
    CmdID_CmdIdAuth = 1001,
};



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




@end

