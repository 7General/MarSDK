//
//  SceneendTask.m
//  GZIMCustomService
//
//  Created by zzg on 2018/4/11.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "SceneEndTask.h"
#import "GZCSLogHelper.h"
#import "Messagecmd.pbobjc.h"
#import "Clienttype.pbobjc.h"

@interface SceneEndTask()

@property (nonatomic, strong) SceneEndSendRequest *request;
@property (nonatomic, strong) SceneEndSendResponse *response;
@property (nonatomic, copy) void (^onResult)(BOOL, SceneEndSendResponse *);

@end

@implementation SceneEndTask

+ (instancetype)SceneEndWithSceneId:(NSString *)scenceId
                              appId:(NSString *)appId
                             chatId:(NSString *)chatId
                                 to:(NSString *)to
                           toDomain:(int32_t)toDomain
                               guid:(NSString *)guid
                            agentId:(NSString *)agentId
                          agentName:(NSString *)agentName
                                ext:(NSString *)ext
                           onResult:(void (^)(BOOL success, SceneEndSendResponse *response))result {
    return [[self alloc] initWithSceneId:scenceId appId:appId chatId:chatId to:to toDomain:toDomain guid:guid agentId:agentId agentName:agentName ext:ext onResult:result];
}

- (instancetype)initWithSceneId:(NSString *)scenceId
                          appId:(NSString *)appId
                         chatId:(NSString *)chatId
                             to:(NSString *)to
                       toDomain:(int32_t)toDomain
                           guid:(NSString *)guid
                        agentId:(NSString *)agentId
                      agentName:(NSString *)agentName
                            ext:(NSString *)ext
                       onResult:(void (^)(BOOL success, SceneEndSendResponse *response))result {
    if (self = [super initAll:ChannelType_LongConn AndCmdId:CmdID_CmdIdSceneEndPush]) {
        self.onResult = result;
        SceneEndSendRequest * request = [SceneEndSendRequest new];
        request.sceneId = scenceId;
        request.appId = appId;
        request.chatId = [chatId longLongValue];
        request.to = to;
        request.toDomain = toDomain;
        request.guid = guid;
        request.agentId = agentId;
        request.agentName = agentName;
        request.ext = ext;
        
        self.request = request;
        self.requestData = [request data];
    }
    return  self;
}



- (void)onDecodeData:(NSData *)responseData {
    self.response = [SceneEndSendResponse parseFromData:responseData error:nil];
    CSLOG_INFO(@"SceneendTask onDecodeData request = %@, response = %@", self.request.description, self.response.description);
}

- (void)onTaskEnd:(int)errType code:(int)errCode {
    CSLOG_INFO(@"SceneendTask onTaskEnd: reponse = %@, errType=%d, errCode=%d", self.response.description, errType, errCode);
    if (self.onResult) {
        self.onResult(errType==0, self.response);
    }
    self.onResult = nil;
}
@end
