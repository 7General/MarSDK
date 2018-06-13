//
//  MARSViewController.m
//  MARSDK
//
//  Created by wanghuizhou21@163.com on 06/12/2018.
//  Copyright (c) 2018 wanghuizhou21@163.com. All rights reserved.
//

#import "MARSViewController.h"


@interface MARSViewController ()//<MARSLongLinkAuthDelegate>

@property (nonatomic) BOOL authed;

@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * guid;
@end

@implementation MARSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    //[[MARSLongLink sharedLongLink] setAuthDelegate:self];
    self.token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJndWF6aSIsInN1YiI6IklNS0YiLCJpYXQiOjE1Mjg4MDMwMTAsImV4cCI6MTUyODgxMDIxMCwiYXVkIjoiRDZDREQyRjQtRDFCNS00OTYxLUE2REYtNTk3ODBEOUQxMDhDIn0.6MmtgPFIjKglHZYPeELqkuhV2KHIDOwo1xRwOJGZ7eI";
    self.guid = @"D6CDD2F4-D1B5-4961-A6DF-59780D9D108C";
    

}






#pragma mark authDelegate
//-(BOOL)longLinkAuthed {
//    return YES;
//}
//
//- (BOOL)longLinkAuthRequestWithUid:(NSString *__autoreleasing *)uid token:(NSString *__autoreleasing *)token domain:(int32_t *)domain guid:(NSString * __autoreleasing *)guid {
//    _authed = NO;
//    *uid = self.guid;
//    *token = self.token;
//    *domain = 5;
//    *guid = self.guid;
//
//    return YES;
//}
//
//- (BOOL)longlinkAuthResponseWithStatus:(int32_t)status errCode:(int32_t)code errMsg:(NSString *)msg timestamp:(int64_t)timestamp{
//    return [self p_parseAuthStatus:status errCode:code andReason:msg];
//}

//- (BOOL)p_parseAuthStatus:(int32_t)status errCode:(int32_t)code andReason:(NSString *)reason {
//    _authed = status == AuthResponse_Status_Ok;
//    // 认证成功，进行拉取离线消息
//    if (_authed) {
//        NSLog(@"success------------------认证成功");
//
//    } else {
//        NSLog(@"%@", [NSString stringWithFormat:@"failure------------------认证失败%@",reason]);
//    }
//
//    return _authed;
//}



@end
