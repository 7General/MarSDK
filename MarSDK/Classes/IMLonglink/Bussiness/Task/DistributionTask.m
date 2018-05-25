//
//  Distribution.m
//  GZIMCustomService
//
//  Created by zzg on 2018/4/11.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "DistributionTask.h"
#import "Messagecmd.pbobjc.h"
#import "Clienttype.pbobjc.h"

@interface DistributionTask()

@property (nonatomic, strong) DistributeRequest *request;
@property (nonatomic, strong) DistributeResponse *response;
@property (nonatomic, copy) void (^onResult)(BOOL, DistributeResponse *);

@end

@implementation DistributionTask

+ (instancetype)DistributionWithFrom:(NSString *)from
                          fromDomain:(int32_t)fromDomain
                                guid:(NSString *)guid
                             sceneId:(NSString *)sceneId
                             content:(NSString *)content
                                type:(int32_t)type
                               appId:(NSString *)appId
                              chatId:(NSString *)chatId
                                 ext:(NSString *)ext
                            onResult:(void (^)(BOOL success, DistributeResponse *response))result {
    return [[self alloc] initWithFrom:from fromDomain:fromDomain guid:guid sceneId:sceneId content:content type:type appId:appId chatId:chatId ext:ext onResult:result];
    
}

- (instancetype)initWithFrom:(NSString *)from
                  fromDomain:(int32_t)fromDomain
                        guid:(NSString *)guid
                     sceneId:(NSString *)sceneId
                     content:(NSString *)content
                        type:(int32_t)type
                       appId:(NSString *)appId
                      chatId:(NSString *)chatId
                         ext:(NSString *)ext
                    onResult:(void (^)(BOOL success, DistributeResponse *response))result {
    if (self = [super initAll:ChannelType_LongConn AndCmdId:CmdID_CmdIdDistributeSend]) {
        self.onResult = result;
        
        DistributeRequest *request = [DistributeRequest new];
        request.from = from;
        request.fromDomain = fromDomain;
        request.guid = guid;
        request.sceneId = sceneId;
        request.content = content;
        request.type = type;
        request.appId = appId;
        request.clientType = ClientType_ClientTypeIos;
        request.chatId = [chatId longLongValue];
        request.ext = ext;
        
        self.request = request;
        self.requestData = [request data];
    }
    return self;
}


- (void)onDecodeData:(NSData *)responseData {
    self.response = [DistributeResponse parseFromData:responseData error:nil];
    CSLOG_INFO(@"DistributionTask onDecodeData request = %@, response = %@", self.request.description, self.response.description);
}

- (void)onTaskEnd:(int)errType code:(int)errCode {
    CSLOG_INFO(@"DistributionTask onTaskEnd: reponse = %@, errType=%d, errCode=%d", self.response.description, errType, errCode);
    if (self.onResult) {
        self.onResult(errType==0, self.response);
    }
    self.onResult = nil;
}

@end
