//
//  AppDelegate.m
//  FirstLove
//
//  Created by ZhaoYu on 16/1/14.
//  Copyright © 2016年 DeTong-Geng. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LocalNotificationViewController.h"
#import "MapViewController.h"
#import "WordSortingViewController.h"   //  单词排序
#import "NSExceptionViewController.h"   //  利用runtime处理异常崩溃
#import "SQLiteViewController.h"    //  基于系统的sql封装
#import "KVO_ManageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //  实现异常捕获的方法。通过回调的方式输出NSException信息。
//    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // __unused 可以取消编译器对未使用的变量提出的警告
//    self.window.rootViewController = [MainViewController new];
//    self.window.rootViewController = [MapViewController new];
//    self.window.rootViewController = [WordSortingViewController new];
//    self.window.rootViewController = [NSExceptionViewController new];
//    self.window.rootViewController = [LocalNotificationViewController new];
//    self.window.rootViewController = [SQLiteViewController new];
    self.window.rootViewController = [KVO_ManageViewController new];

    [self.window makeKeyAndVisible];

    return YES;
}

void UncaughtExceptionHandler(NSException *exception) {
    NSLog(@"自定义获取异常 name %@",exception.name);
    NSLog(@"自定义获取异常 reason %@",exception.reason);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"notification %@",notification);
    NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badgeNumber--;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badgeNumber;
    
    
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];  //  取消所有通知
}


@end
