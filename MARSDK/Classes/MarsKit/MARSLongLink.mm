// Tencent is pleased to support the open source community by making GAutomator available.
// Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.

// Licensed under the MIT License (the "License"); you may not use this file except in 
// compliance with the License. You may obtain a copy of the License at
// http://opensource.org/licenses/MIT

// Unless required by applicable law or agreed to in writing, software distributed under the License is
// distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied. See the License for the specific language governing permissions and
// limitations under the License.

#import "MARSLongLink.h"
#import "CGITask.h"
#import "NetworkStatus.h"

#import "app_callback.h"
#import "stn_callback.h"
#import "stnproto_logic.h"
#import <mars/app/app_logic.h>
#import <mars/stn/stn_logic.h>
#import <mars/baseevent/base_logic.h>

#import <SystemConfiguration/SCNetworkReachability.h>


NSString * const kMARSLongLinkStatusObserverName = @"kMARSLongLinkStatusObserverName";
NSString * const kMARSLongLinkStatus = @"kMARSLongLinkStatus";
NSString * const kMARSLongLinkUniqueTaskId = @"kMARSLongLinkUniqueTaskId";

using namespace mars::stn;
@interface MARSLongLink () <NetworkStatusDelegate>
{
    NSMapTable *_pushObservers;
    NSMutableDictionary *_sendTaskDictionary;
}
@end

@implementation MARSLongLink

+ (MARSLongLink*)sharedLongLink {
    static MARSLongLink *sharedSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[MARSLongLink alloc] init];
    });
    return sharedSingleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _pushObservers = [NSMapTable strongToWeakObjectsMapTable];
        _sendTaskDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    _pushObservers = nil;
    _sendTaskDictionary = nil;
}

- (void)addLongLinkPushObserver:(id<MARSLongLinkPushDelegate>)observer withCmdId:(CmdID)cmdId {
    [_pushObservers setObject:observer forKey:@(cmdId)];
}

#pragma mark - Public
- (void)createLongLinkWithAddress:(NSString *)addr ports:(NSArray *)ports clientVersion:(uint32_t)version {
    mars::stn::SetCallback(mars::stn::StnCallBack::Instance());
    mars::app::SetCallback(mars::app::AppCallBack::Instance());
    
    mars::baseevent::OnCreate();
    mars::stn::SetClientVersion(version);
    
    std::string ipAddress([addr UTF8String]);
    std::vector<uint16_t> cports;
    for (id port in ports) {
        cports.push_back([port unsignedShortValue]);
    }
    mars::stn::SetLonglinkSvrAddr(ipAddress,cports,"");
    mars::baseevent::OnForeground(YES);
    mars::stn::MakesureLonglinkConnected();
    mars::stn::SetSignallingStrategy(5,270);
    [[NetworkStatus sharedInstance] Start:self];
}

- (void)destoryLongLink {
    mars::baseevent::OnDestroy();
}
- (void)reSetLongLink {
    mars::stn::Reset();
}

- (void)makesureLongLinkConnect {
    mars::stn::MakesureLonglinkConnected();
}

- (BOOL)longLinkIsConnected {
    return mars::stn::LongLinkIsConnected();
}

- (void)reportOnForegroud:(BOOL)foreground {
    mars::baseevent::OnForeground(foreground);
}

- (uint32_t)nextTaskId {
    uint32_t taskid = [[[NSUserDefaults standardUserDefaults] objectForKey:kMARSLongLinkUniqueTaskId] unsignedIntValue];
    uint32_t nextTaskId = 1;
    if (taskid > 0 || taskid < 0xF0000000) {
        nextTaskId = taskid+1;
    }
    [[NSUserDefaults standardUserDefaults] setObject:@(nextTaskId) forKey:kMARSLongLinkUniqueTaskId];
    return nextTaskId;
}

- (uint32_t)startTask:(CGITask*)task {
    uint32_t taskid = [self nextTaskId];
    Task ctask(taskid);
    
    ctask.cmdid = task.cmdid;
    ctask.channel_select = task.channel_select;
    ctask.cgi = std::string(task.cgi.UTF8String);
    ctask.shortlink_host_list.push_back(std::string(task.host.UTF8String));
    
    ctask.send_only = task.send_only;
    ctask.need_authed = task.need_auth;
    ctask.retry_count = task.retry_count;
    
    ctask.user_context = (__bridge void*)task;
    
    [_sendTaskDictionary setObject:task forKey:@(taskid)];
    
    mars::stn::StartTask(ctask);
    return ctask.taskid;
}

#pragma mark - Bussiness
- (uint32_t)startAuthWithUserId:(NSString *)uid token:(NSString *)token guid:(NSString *)guid appid:(NSString *)appid domain:(int32_t)domain onResult:(void (^)(BOOL, AuthResponse *))result {
    return [self startTask:[AuthTask taskWithUserId:uid token:token guid:(NSString *)guid appid:(NSString *)appid domain:domain onResult:result]];
}


#pragma mark - Callback
- (void)OnConnectionStatusChange:(int)status longConnStatus:(int)longConnStatus
{
    MARSLongLinkStatus llStatus;
    switch (longConnStatus) {
        case 4:
            llStatus = MARSLongLinkStatusConnected;
            break;
        case 3:
            llStatus = MARSLongLinkStatusConnecting;
            break;
        default:
            llStatus = MARSLongLinkStatusDisconnected;
            break;
    }
    __weak typeof(self) weakSelf = self;
    if (_connectDelegate && [_connectDelegate respondsToSelector:@selector(longlinkContectStatusDidChanged:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.connectDelegate longlinkContectStatusDidChanged:llStatus];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kMARSLongLinkStatusObserverName object:nil userInfo:@{kMARSLongLinkStatus:@(llStatus)}];
        });
    }
}

- (void)OnPushWithCmd:(int)cmdId data:(NSData *)data {
    id<MARSLongLinkPushDelegate> pushObserver = [_pushObservers objectForKey:@(cmdId)];
    if (pushObserver && [pushObserver respondsToSelector:@selector(longlinkPushMessage:withCmdId:)]) {
        [pushObserver longlinkPushMessage:data withCmdId:cmdId];
    }
}


- (NSData*)Request2BufferWithTaskID:(uint32_t)tid userContext:(const void *)context {
    NSData* data = NULL;
    CGITask *task = [_sendTaskDictionary objectForKey:@(tid)];
    if (task) {
        data = [task requestData];
    }
    if (task.send_only) { // 只发送的从这里移除，否则一直占用内存
        [_sendTaskDictionary removeObjectForKey:@(tid)];
    }
    return data;
}

- (int)Buffer2ResponseWithTaskID:(uint32_t)tid ResponseData:(NSData *)data userContext:(const void *)context {
    CGITask *task = [_sendTaskDictionary objectForKey:@(tid)];
    if (task) {
        [task onDecodeData:data];
    }
    return 0;
}

- (int)OnTaskEndWithTaskID:(uint32_t)tid userContext:(const void *)context errType:(int)errtype errCode:(int)errcode; {
    CGITask *task = [_sendTaskDictionary objectForKey:@(tid)];
    if (task) {
        [task onTaskEnd:errtype code:errcode];
    }
    [_sendTaskDictionary removeObjectForKey:@(tid)];
    return 0;
}

- (BOOL)isAuthed {
    BOOL authed = NO;
    if (_authDelegate && [_authDelegate respondsToSelector:@selector(longLinkAuthed)]) {
        authed = [_authDelegate longLinkAuthed];
    }
    return authed;
}

- (CmdID)authCmdId {
    return CmdID_CmdIdAuth;
}

- (NSData*)authRequestData {
    NSData* data = NULL;
    if (_authDelegate && [_authDelegate respondsToSelector:@selector(longLinkAuthRequestWithUid:token:domain:guid:)]) {
        NSString *uid = nil;
        NSString *token = nil;
        int32_t domain;
        NSString *guid = nil;
        
        BOOL ok = [_authDelegate longLinkAuthRequestWithUid:&uid token:&token domain:&domain guid:&guid];
        if (ok) {
            AuthRequest *request = [AuthRequest new];
            request.uid = uid;
            request.token = token;
            request.domain = domain;
            request.guid = guid;
            request.appId = @"GUAZI";
            request.timestamp = (int64_t)([[NSDate date] timeIntervalSince1970]*1000);
            data = [request data];
        }
    }
    return data;
}

- (BOOL)authResponseData:(NSData*)responseData {
    BOOL authed = NO;
    if (_authDelegate && [_authDelegate respondsToSelector:@selector(longlinkAuthResponseWithStatus:errCode:errMsg:timestamp:)]) {
        AuthResponse *response = [AuthResponse parseFromData:responseData error:nil];
        authed = [_authDelegate longlinkAuthResponseWithStatus:response.status errCode:response.code errMsg:response.msg timestamp:response.timestamp];
    }
    return authed;
}

#pragma mark - NetworkStatusDelegate
-(void)ReachabilityChange:(UInt32)uiFlags {
    if ((uiFlags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
        mars::baseevent::OnNetworkChange();
    }
}

@end

