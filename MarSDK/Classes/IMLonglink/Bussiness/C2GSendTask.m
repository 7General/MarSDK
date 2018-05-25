//
//  C2GSendTask.m
//  GZIMClient
//
//  Created by zhouxueyun on 2017/4/26.
//  Copyright © 2017年 呱呱开放平台. All rights reserved.
//

#import "C2GSendTask.h"
#import "GZCSLogHelper.h"
#import "Messagecmd.pbobjc.h"
#import "Clienttype.pbobjc.h"

@interface C2GSendTask()

@property (nonatomic, strong) C2GSendRequest *request;
@property (nonatomic, strong) C2GSendResponse *response;
@property (nonatomic, copy) void(^onResult)(BOOL, C2GSendResponse *);

@end

@implementation C2GSendTask

+ (instancetype)taskWithFrom:(NSString *)from fromName:(NSString *)fromName group:(NSString *)group content:(NSString *)content type:(int32_t)type onResult:(void (^)(BOOL, C2GSendResponse *))result
{
    return [[[self class] alloc] initWithFrom:from fromName:fromName group:group content:content type:type onResult:result];
}

- (instancetype)initWithFrom:(NSString *)from fromName:(NSString *)fromName group:(NSString *)group content:(NSString *)content type:(int32_t)type onResult:(void (^)(BOOL, C2GSendResponse *))result
{
    if (self = [super initAll:ChannelType_LongConn AndCmdId:CmdID_CmdIdC2Gsend]) {
        self.onResult = result;

        C2GSendRequest *request = [C2GSendRequest new];
        request.from = from;
        request.fromName = fromName;
        request.chatId = [group longLongValue];
        request.content = content;
        request.type = type;
        
        self.request = request;
        self.requestData = [request data];
    }
    return self;
}

- (void)onDecodeData:(NSData *)responseData
{
    self.response = [C2GSendResponse parseFromData:responseData error:nil];
    CSLOG_INFO(@"C2GSendTask onDecodeData: request = %@, response = %@", self.request.description, self.response.description);
}

- (void)onTaskEnd:(int)errType code:(int)errCode
{
    CSLOG_INFO(@"C2GSendTask onTaskEnd: request = %@, errType = %d, errCode = %d", self.request.description, errType, errCode);
    if (self.onResult) {
        self.onResult(errType==0, self.response);
    }
    self.onResult = nil;
}


@end
