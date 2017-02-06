//
//  main.m
//  XlogTest
//
//  Created by yxn on 2017/2/6.
//  Copyright © 2017年 Dianping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <sys/xattr.h>
#import <mars/xlog/xloggerbase.h>
#import <mars/xlog/xlogger.h>
#import <mars/xlog/appender.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        
//1、设置存储区
        NSString* logPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/log"];
        
        // set do not backup for logpath
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        setxattr([logPath UTF8String], attrName, &attrValue, sizeof(attrValue), 0, 0);
//2、 init xlog
        #if DEBUG
                xlogger_SetLevel(kLevelDebug);
                appender_set_console_log(true);
        #else
                xlogger_SetLevel(kLevelInfo);
                appender_set_console_log(false);
        #endif
        appender_open(kAppednerAsync, [logPath UTF8String], "Test");

        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
