//
//  LogoutTask.m
//  GZIMClient
//
//  Created by zhouxueyun on 2017/5/19.
//  Copyright © 2017年 呱呱开放平台. All rights reserved.
//

#import "LogoutTask.h"
#import "Logout.pbobjc.h"
#import "Messagecmd.pbobjc.h"
#import "Clienttype.pbobjc.h"

@implementation LogoutTask

+ (instancetype)taskWithUserId:(NSString *)uid andToken:(NSString *)token {
    return [[[self class] alloc] initWithUserId:uid andToken:token];
}

- (instancetype)initWithUserId:(NSString *)uid andToken:(NSString *)token {
    if (self = [super initAll:ChannelType_LongConn AndCmdId:CmdID_CmdIdLogout]) {
        self.send_only = true;
        self.need_auth = false;
        LogoutRequest *request = [LogoutRequest new];
        request.uid = uid;
        request.token = token;
        request.timestamp = (int64_t)([[NSDate date] timeIntervalSince1970]*1000);;
        self.requestData = [request data];
    }
    return self;
}

@end
