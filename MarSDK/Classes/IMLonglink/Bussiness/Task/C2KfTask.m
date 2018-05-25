//
//  C2KfTask.m
//  GZCSCustomService
//
//  Created by zzg on 2018/4/11.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "C2KfTask.h"
#import "Messagecmd.pbobjc.h"
#import "Clienttype.pbobjc.h"

@interface C2KfTask()

@property (nonatomic, strong) C2KfRequest *request;
@property (nonatomic, strong) C2KfResponse *response;
@property (nonatomic, copy) void (^onResult)(BOOL, C2KfResponse *);

@end

@implementation C2KfTask


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
                    onResult:(void (^)(BOOL success, C2KfResponse *response))result {
    return [[self alloc] initWithFrom:from
                             fromName:fromName
                           fromDomain:fromDomain
                                 guid:guid
                               chatId:chatId
                              sceneId:sceneId
                              content:content
                                 type:type
                                appId:appId
                                  ext:ext
                             onResult:result];
}

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
                    onResult:(void (^)(BOOL success, C2KfResponse *response))result {
    
    if (self = [super initAll:ChannelType_LongConn AndCmdId:CmdID_CmdIdC2Kf]) {
        self.onResult = result;
        
        C2KfRequest * request = [C2KfRequest new];
        request.from = from;
        request.fromName = fromName;
        request.fromDomain = fromDomain;
        request.guid = guid;
        request.chatId = [chatId longLongValue];
        request.sceneId = sceneId;
        request.content = content;
        request.type = type;
        request.appId = appId;
        request.ext = ext;
        
        self.request = request;
        self.requestData = [request data];
    }
    return  self;
}

- (void)onDecodeData:(NSData *)responseData {
    self.response = [C2KfResponse parseFromData:responseData error:nil];
    CSLOG_INFO(@"C2KfTask onDecodeData request = %@, response = %@", self.request.description, self.response.description);
}

- (void)onTaskEnd:(int)errType code:(int)errCode {
    CSLOG_INFO(@"C2KfTask onTaskEnd: reponse = %@, errType=%d, errCode=%d", self.response.description, errType, errCode);
    if (self.onResult) {
        self.onResult(errType==0, self.response);
    }
    self.onResult = nil;
}

@end
