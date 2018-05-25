//
//  AuthTask.h
//  GZIMCustomService
//
//  Created by zzg on 2018/3/20.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#import "CGITask.h"
#import "Auth.pbobjc.h"

@interface AuthTask : CGITask

+ (instancetype)taskWithUserId:(NSString *)uid token:(NSString *)token domain:(int32_t)domain onResult:(void(^)(BOOL success,AuthResponse * response))result;

- (instancetype)initWithUserId:(NSString *)uid token:(NSString *)token domain:(int32_t)domain onResult:(void(^)(BOOL success,AuthResponse * response))result;

@end
