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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
//    self.window.rootViewController = [MainViewController new];
//    self.window.rootViewController = [MapViewController new];
//    self.window.rootViewController = [WordSortingViewController new];
    self.window.rootViewController = [NSExceptionViewController new];
//    self.window.rootViewController = [LocalNotificationViewController new];
    [self.window makeKeyAndVisible];

    
    return YES;
}

void UncaughtExceptionHandler(NSException *exception) {
    NSLog(@"name %@",exception.name);
    NSLog(@"reason %@",exception.reason);
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
