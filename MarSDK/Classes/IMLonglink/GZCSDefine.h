//
//  GZCSDefine.h
//  GZIMCustomService
//
//  Created by coderPoo on 2018/3/28.
//  Copyright © 2018年 guagua-ios. All rights reserved.
//

#ifndef GZCSDefine_h
#define GZCSDefine_h


#define MARS_CLIENT_VERSION       200

#ifdef RELEASE
#define LONG_LINK_IP                 @"10.16.208.124"
#define LONG_LINK_PORTS              @[@(8079)]

#else
#define LONG_LINK_IP                 @"10.16.208.124"
#define LONG_LINK_PORTS              @[@(8079)]

#endif

// 字符串是否为空
#define kGZCSUniqueIDString         @"com.guazi.im.uniqueID"
#define kGZCSUnifiedAccessGroupkey  @"QNBW2BT8S6.com.guazi.imUniqueId"

#define CURRENT_TIME_MILLS             (int64_t)([[NSDate date] timeIntervalSince1970]*1000)
#define CURRENT_TIME_SECONDS           (NSInteger)[[NSDate date] timeIntervalSince1970]

#define GZCS_WS(weakSelf)                __weak __typeof(self) weakSelf = self

#define NoNilString(str)            (str.length > 0 ? str : @"")
#define StringWithInt(value)        [NSString stringWithFormat:@"%d",value]
#define StringWithLong(value)       [NSString stringWithFormat:@"%ld",value]
#define StringWithLongLong(value)   [NSString stringWithFormat:@"%lld",value]
#define StringWithULong(value)      [NSString stringWithFormat:@"%lu",value]
#define StringWithULongLong(value)  [NSString stringWithFormat:@"%llu",value]

#define IOSVER              [GZCSUtil currentSystemVersion]


// 字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

#define kGZCSBundleVersion          [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"]
#define kGZIMBundleShortVersion     [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]


//-----------------UIKit --------------//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define SCREEN_SCALE          [UIScreen mainScreen].scale

#define HEIGHT_TAB_BAR                  49
#define HEIGHT_STATUS_BAR               (SCREEN_HEIGHT==812?44:20) //For iPhoneX 44, else 20, fix scrollView wrong offset when in-call
#define HEIGHT_NAV_BAR                  44
#define HEIGHT_NAV_STATUS_BAR           (HEIGHT_NAV_BAR+HEIGHT_STATUS_BAR)
#define HEIGHT_BOTTOM_MARGIN            (SCREEN_HEIGHT==812?34:0)  //For iPhoneX

#define HEIGHT_CHATBAR                  50.0f
#define HEIGHT_CHATBAR_TEXTVIEW         40.0f
#define HEIGHT_MAX_CHATBAR_TEXTVIEW     111.5f
#define HEIGHT_CHAT_KEYBOARD            215.0f

#define GZCS_RGBACOLOR(r,g,b,a)             [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define GZCS_RGBCOLOR(r,g,b)                GZCS_RGBACOLOR(r,g,b,1.0f)

#define COLOR_CHAT_BAR                 GZCS_RGBCOLOR( 245, 245, 247)

#define HEIGHT_LINE_1DP                 1

#define SEVEN_DAYS_SECONDS             7*24*60*60
#define SEVEN_DAYS_MILLISECONDS        7*24*60*60*1000
#define COLOR_NAV_BAR_BG                GZCS_RGBCOLOR(0xfe,0xfe,0xff)   //默认导航bar颜色
#define COLOR_NAV_BAR_TINT              GZCS_RGBCOLOR(30,37,41)   //默认导航bar tint颜色
#define COLOR_BACKGROUND                GZCS_RGBCOLOR(0xf5,0xf7,0xfa)   //默认背景颜色

#define COLOR_MAIN              GZCS_RGBCOLOR(0x1f,0xcd,0xbb)   // default
#define COLOR_MAIN_HL           GZCS_RGBCOLOR(0x28,0xbb,0xac)   // highlighted
#define COLOR_MAIN_DISABLED     GZCS_RGBCOLOR(0xBD,0xc1,0xC8)   // disabled

#define COLOR_MAIN_LINE         GZCS_RGBCOLOR(0xf4,0xf4,0xf4)
#define COLOR_MAIN_BG           GZCS_RGBCOLOR(0xff,0xff,0xff)
#define COLOR_MAIN_BG_HL        GZCS_RGBCOLOR(0xf1,0xf2,0xf8)
#define COLOR_MAIN_TITLE        GZCS_RGBCOLOR(0x3a,0x3a,0x3a)
#define COLOR_MAIN_SUBTITLE     GZCS_RGBCOLOR(0xBD,0xC1,0xC8)
#define COLOR_MAIN_CONTENT      GZCS_RGBCOLOR(0x9e,0xa0,0xae)

#define COLOR_LOCAL_RED         GZCS_RGBCOLOR(0xee,0x4f,0x45)
#define COLOR_LOCAL_BLUE        GZCS_RGBCOLOR(0x15,0x7E,0xFB)

#define kGZIMWatermarkFont          [UIFont systemFontOfSize:16]



#endif /* GZCSDefine_h */
