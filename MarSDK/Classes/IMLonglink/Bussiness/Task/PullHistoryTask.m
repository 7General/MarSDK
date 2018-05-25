//
//  PullHistoryTask.m
//  GZIMClient
//
//  Created by zhouxueyun on 2017/8/1.
//  Copyright © 2017年 呱呱开放平台. All rights reserved.
//

#import "PullHistoryTask.h"
#import "Messagecmd.pbobjc.h"
#import "GZCSLogHelper.h"
#import "Clienttype.pbobjc.h"

@interface PullHistoryTask ()

@property (nonatomic, strong) PullHistoryRequest *request;
@property (nonatomic, strong) PullHistoryResponse *response;
@property (nonatomic, copy) void (^onResult)(BOOL, PullHistoryResponse *);

@end

@implementation PullHistoryTask

+ (instancetype)taskWithUserId:(NSString *)uid
                        domain:(int32_t)domain
                        chatId:(NSString *)chatId
                         appId:(NSString *)appId
                       sceneId:(NSString *)sceneId
                        offset:(int64_t)offset
                         count:(int32_t)count
                         logId:(NSString *)logId
                      onResult:(void (^)(BOOL success, PullHistoryResponse *response))result {
    return [[[self class] alloc] initWithUserId:uid domain:domain chatId:chatId appId:appId sceneId:sceneId  offset:offset count:count logId:logId onResult:result];
}

- (instancetype)initWithUserId:(NSString *)uid
                        domain:(int32_t)domain
                        chatId:(NSString *)chatId
                         appId:(NSString *)appId
                       sceneId:(NSString *)sceneId
                        offset:(int64_t)offset
                         count:(int32_t)count
                         logId:(NSString *)logId
                      onResult:(void (^)(BOOL success, PullHistoryResponse *response))result {
    if (self = [super initAll:ChannelType_LongConn AndCmdId:CmdID_CmdIdHistory]) {
        self.onResult = result;
        
        PullHistoryRequest *request = [PullHistoryRequest new];
        request.uid = uid;
        request.domain = domain;
        request.chatId = [chatId longLongValue];
        request.appId = appId;
        request.sceneId = sceneId;
        request.clientType = ClientType_ClientTypeIos;
        request.offset = offset;
        request.limit = count;
        request.logId = logId;

        self.request = request;
        self.requestData = [request data];
    }
    return self;
}

- (void)onDecodeData:(NSData *)responseData {
    self.response = [PullHistoryResponse parseFromData:responseData error:nil];
    CSLOG_INFO(@"PullHistoryTask onDecodeData: request = %@, response = %@", self.request.description, self.response.description);
}

- (void)onTaskEnd:(int)errType code:(int)errCode {
    CSLOG_INFO(@"PullHistoryTask onTaskEnd: reponse = %@, errType = %d, errCode = %d", self.response.description, errType, errCode);
    if (self.onResult) {
        self.onResult(errType==0, self.response);
    }
    self.onResult = nil;
}

@end
