//
//  MARSAppDelegate.m
//  MARSDK
//
//  Created by wanghuizhou21@163.com on 06/12/2018.
//  Copyright (c) 2018 wanghuizhou21@163.com. All rights reserved.
//

#import "MARSAppDelegate.h"

//#import <MARSDK/MARSLongLink.h>
//#import <MARSDK/MARSLogHelper.h>


@implementation MARSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    [[MARSLongLink sharedLongLink] createLongLinkWithAddress:@"1.6.8.1" ports:@[@(8079)] clientVersion:200];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

//    [[MARSLongLink sharedLongLink] reportOnForegroud:NO];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

//    [[MARSLongLink sharedLongLink] reportOnForegroud:YES];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{

//    [[MARSLongLink sharedLongLink] destoryLongLink];
//    [MARSLogHelper closeXLog];

}

@end
