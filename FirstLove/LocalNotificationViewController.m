//
//  LocalNotificationViewController.m
//  FirstLove
//
//  Created by ZhaoYu on 16/2/16.
//  Copyright © 2016年 DeTong-Geng. All rights reserved.
//

#import "LocalNotificationViewController.h"

@interface LocalNotificationViewController ()

@end

@implementation LocalNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self scheduleNotificationWithFireDate:[[NSDate date] dateByAddingTimeInterval:10] timeZone:[NSTimeZone systemTimeZone] repeatInterval:0 alertBody:@"body" alertAction:@"action" launchImage:@"" soundName:nil badgeNumber:1 andUserInfo:@{@"aaa":@"bbb"}];
}




- (void)scheduleNotificationWithFireDate:(NSDate *)fireDate
                                timeZone:(NSTimeZone *)timeZone
                          repeatInterval:(NSCalendarUnit)repeatInterval
                               alertBody:(NSString *)alertBody
                             alertAction:(NSString *)alertAction
                             launchImage:(NSString *)launchImage
                               soundName:(NSString *)soundName
                             badgeNumber:(NSInteger)badgeNumber
                             andUserInfo:(NSDictionary *)userInfo
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = fireDate;
    localNotification.timeZone = timeZone;
    localNotification.repeatInterval = repeatInterval;
    localNotification.alertBody = alertBody;
    localNotification.alertLaunchImage = launchImage;
    localNotification.soundName = soundName;
    localNotification.applicationIconBadgeNumber = badgeNumber;
    localNotification.userInfo = userInfo;
    
    if (alertAction == nil) {
        localNotification.hasAction = NO;
    }else {
        localNotification.alertAction = alertAction;
    }
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        NSLog(@"添加授权");
    } else {
        NSLog(@"未添加授权");
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
