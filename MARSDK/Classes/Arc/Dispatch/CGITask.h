// Tencent is pleased to support the open source community by making GAutomator available.
// Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.

// Licensed under the MIT License (the "License"); you may not use this file except in 
// compliance with the License. You may obtain a copy of the License at
// http://opensource.org/licenses/MIT

// Unless required by applicable law or agreed to in writing, software distributed under the License is
// distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied. See the License for the specific language governing permissions and
// limitations under the License.

#import <Foundation/Foundation.h>
#import "GZCSLogHelper.h"

typedef enum : int32_t {
    ChannelType_ShortConn = 1,
    ChannelType_LongConn = 2,
    ChannelType_All = 3
} ChannelType;

@interface CGITask : NSObject

@property(nonatomic) uint32_t cmdid;
@property(nonatomic) ChannelType channel_select;
@property(nonatomic, copy) NSString *cgi;
@property(nonatomic, copy) NSString *host;

@property(nonatomic) bool send_only;
@property(nonatomic) bool need_auth; // 需要authed
@property(nonatomic) int32_t retry_count; // 重试次数

- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId;
- (instancetype)initAll:(ChannelType)ChannelType AndCmdId:(uint32_t)cmdId AndCGIUri:(NSString*)cgiUri AndHost:(NSString*)host;

// call for GZIMLongLink/stn_callback
@property(nonatomic, copy) NSData* requestData;
- (void)onDecodeData:(NSData*)responseData;
- (void)onTaskEnd:(int)errType code:(int)errCode;

@end
