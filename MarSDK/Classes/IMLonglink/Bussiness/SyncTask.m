//
//  SyncTask.m
//  GZIMCustomService
//
//  Created by zzg on 2018/3/29.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "SyncTask.h"
#import "Messagecmd.pbobjc.h"
#import "Clienttype.pbobjc.h"

@interface SyncTask()

@property (nonatomic, strong) SyncRequest *request;
@property (nonatomic, strong) SyncResponse *response;
@property (nonatomic, copy) void (^onResult)(BOOL, SyncResponse *);
@end

@implementation SyncTask

+ (instancetype)syncWithUid:(NSString *)uid
                     domain:(int32_t)domain
                     offect:(int64_t)offect
                      limit:(int32_t)limit
                      logId:(NSString *)logId
                      appId:(NSString *)appId
                   onResult:(void (^)(BOOL success, SyncResponse *response))result {
    return [[self alloc] initWithUid:uid domain:domain offect:offect limit:limit logId:logId appId:appId onResult:result];
}

- (instancetype)initWithUid:(NSString *)uid
                     domain:(int32_t)domain
                     offect:(int64_t)offect
                      limit:(int32_t)limit
                      logId:(NSString *)logId
                      appId:(NSString *)appId
                   onResult:(void (^)(BOOL success, SyncResponse *response))result {
    if (self = [super initAll:ChannelType_LongConn AndCmdId:CmdID_CmdIdSync]) {
        SyncRequest * requset = [[SyncRequest alloc] init];
        requset.uid = uid;
        requset.domain = domain;
        requset.offset = offect;
        requset.limit = limit;
        requset.logId = logId;
        requset.clientType = ClientType_ClientTypeIos;
        requset.appId = appId;
        
        self.onResult = result;
        
        self.request = requset;
        self.requestData = [requset data];
    }
    return self;
}



- (void)onDecodeData:(NSData *)responseData {
    self.response = [SyncResponse parseFromData:responseData error:nil];
    CSLOG_INFO(@"SyncTask onDecodeData request = %@, response = %@", self.request.description, self.response.description);
}

- (void)onTaskEnd:(int)errType code:(int)errCode {
    CSLOG_INFO(@"SyncTask onTaskEnd: reponse = %@, errType=%d, errCode=%d", self.response.description, errType, errCode);
    if (self.onResult) {
        self.onResult(errType==0, self.response);
    }
    self.onResult = nil;
}

@end
