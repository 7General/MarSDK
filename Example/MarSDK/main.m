//
//  main.m
//  MARSDK
//
//  Created by wanghuizhou21@163.com on 06/12/2018.
//  Copyright (c) 2018 wanghuizhou21@163.com. All rights reserved.
//

@import UIKit;
#import "MARSAppDelegate.h"
#import <MARSDK/MARSLogHelper.h>

int main(int argc, char * argv[])
{
    @autoreleasepool {
        NSString* logPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/xlog/log"];
#if RELEASE
        [MARSLogHelper openXLogWithPath:logPath logLever:kLevelInfo];
#else
        [MARSLogHelper openXLogWithPath:logPath logLever:kLevelDebug];
#endif
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([MARSAppDelegate class]));
    }
}
