//
//  AuthTask.m
//  GZIMCustomService
//
//  Created by zzg on 2018/3/20.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "AuthTask.h"

#import "MARSLogHelper.h"
#import "Messagecmd.pbobjc.h"

@interface AuthTask()
@property (nonatomic, strong) AuthRequest *request;
@property (nonatomic, strong) AuthResponse *response;
@property (nonatomic, copy) void (^onResult)(BOOL, AuthResponse *);
@end


@implementation AuthTask
+ (instancetype)taskWithUserId:(NSString *)uid token:(NSString *)token guid:(NSString *)guid appid:(NSString *)appid domain:(int32_t)domain onResult:(void(^)(BOOL success,AuthResponse * response))result {
    return [[self alloc] initWithUserId:uid token:token guid:guid appid:appid domain:domain onResult:result];
}

- (instancetype)initWithUserId:(NSString *)uid token:(NSString *)token guid:(NSString *)guid appid:(NSString *)appid domain:(int32_t)domain onResult:(void(^)(BOOL success,AuthResponse * response))result {
    if (self = [super initAll:ChannelType_LongConn AndCmdId:CmdID_CmdIdAuth]) {
        self.need_auth = false;
        self.onResult = result;
        
        AuthRequest * request = [AuthRequest new];
        request.uid = uid;
        request.token = token;
        //request.clientType = ClientType_ClientTypeIos;
        request.guid = guid;
        request.appId = appid;
        request.domain = domain;
        
        request.timestamp = (int64_t)([[NSDate date] timeIntervalSince1970]*1000);
        
        self.request = request;
        self.requestData = [request data];
        
        CSLOG_INFO(@"AuthTask-request: request=%@",self.request.description);
    }
    return self;
}

-(void)onDecodeData:(NSData *)responseData {
    self.response = [AuthResponse parseFromData:responseData error:nil];
    
}
- (void)onTaskEnd:(int)errType code:(int)errCode {
    CSLOG_INFO(@"C2AiTask onTaskEnd: reponse = %@, errType=%d, errCode=%d", self.response.description, errType, errCode);
    if (self.onResult) {
        self.onResult(errCode == 0, self.response);
    }
    self.onResult = nil;
}
@end
