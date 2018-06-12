// Tencent is pleased to support the open source community by making Mars available.
// Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.

// Licensed under the MIT License (the "License"); you may not use this file except in 
// compliance with the License. You may obtain a copy of the License at
// http://opensource.org/licenses/MIT

// Unless required by applicable law or agreed to in writing, software distributed under the License is
// distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied. See the License for the specific language governing permissions and
// limitations under the License.

//
//  GZIMLogHelper.h
//  iOSDemo
//
//  Created by caoshaokun on 16/11/30.
//  Copyright © 2016年 caoshaokun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mars/xlog/xloggerbase.h>

@interface GZCSLogHelper : NSObject

+ (void)openXLogWithPath:(NSString *)path logLever:(TLogLevel)level;
+ (void)closeXLog;

+ (void)setModelName:(NSString *)model;

+ (BOOL)hasOpenXLog;
+ (BOOL)shouldLog:(TLogLevel)level;
+ (void)logWithLevel:(TLogLevel)logLevel fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message;

@end

// XLOG
#define LogInternal(level, file, line, func, prefix, format, ...) \
do { \
    if ([GZCSLogHelper hasOpenXLog] && [GZCSLogHelper shouldLog:level]) { \
        NSString *aMessage = [NSString stringWithFormat:@"%@%@", prefix, [NSString stringWithFormat:format, ##__VA_ARGS__, nil]]; \
        [GZCSLogHelper logWithLevel:level fileName:file lineNumber:line funcName:func message:aMessage]; \
    } \
} while(0)

#define __FILENAME__                (strrchr(__FILE__,'/')+1)
#define CSLOG_ERROR(format, ...)     LogInternal(kLevelError, __FILENAME__, __LINE__, __FUNCTION__, @"Error:", format, ##__VA_ARGS__)
#define CSLOG_WARNING(format, ...)   LogInternal(kLevelWarn, __FILENAME__, __LINE__, __FUNCTION__, @"Warning:", format, ##__VA_ARGS__)
#define CSLOG_INFO(format, ...)      LogInternal(kLevelInfo, __FILENAME__, __LINE__, __FUNCTION__, @"Info:", format, ##__VA_ARGS__)
#define CSLOG_DEBUG(format, ...)     LogInternal(kLevelDebug, __FILENAME__, __LINE__, __FUNCTION__, @"Debug:", format, ##__VA_ARGS__)


