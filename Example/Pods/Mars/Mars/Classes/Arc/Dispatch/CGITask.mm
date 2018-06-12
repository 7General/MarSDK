// Tencent is pleased to support the open source community by making GAutomator available.
// Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.

// Licensed under the MIT License (the "License"); you may not use this file except in 
// compliance with the License. You may obtain a copy of the License at
// http://opensource.org/licenses/MIT

// Unless required by applicable law or agreed to in writing, software distributed under the License is
// distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied. See the License for the specific language governing permissions and
// limitations under the License.

#import "CGITask.h"

@implementation CGITask

- (instancetype)init
{
    if (self = [super init]) {
        self.send_only = false;
        self.need_auth = true;
        self.retry_count = 3;
    }
    return self;
}

- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId
{
    return [self initAll:channelType AndCmdId:cmdId AndCGIUri:@"" AndHost:@""];
}

- (instancetype)initAll:(ChannelType)channelType AndCmdId:(uint32_t)cmdId AndCGIUri:(NSString*)cgiUri AndHost:(NSString*)host
{
    if (self = [self init]) {
        self.channel_select = channelType;
        self.cmdid = cmdId;
        self.cgi = cgiUri;
        self.host = host;
    }
    return self;
}

- (void)onDecodeData:(NSData*) responseData
{
}

- (void)onTaskEnd:(int)errType code:(int)errCode
{
}

@end
