//
//  MapViewController.m
//  FirstLove
//
//  Created by ZhaoYu on 16/2/17.
//  Copyright © 2016年 DeTong-Geng. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()<CLLocationManagerDelegate>

{
    CLLocationManager *locationManager;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = 1.0;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        
        NSLog(@"请求授权");
        [locationManager requestAlwaysAuthorization]; // 永久授权
        [locationManager requestWhenInUseAuthorization]; //使用中授权
    }
    
    [locationManager startUpdatingLocation];

    
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"%@",locations);
    CLLocation *location = [locations lastObject];
    NSLog(@"纬度 %f",location.coordinate.latitude);
    NSLog(@"经度 %f",location.coordinate.longitude);
    NSLog(@"海拔高度 %f",location.altitude);
    NSLog(@"水平精度 %f",location.horizontalAccuracy);
    NSLog(@"海拔精度 %f",location.verticalAccuracy);
    NSLog(@"地面 %@",location.floor);
    NSLog(@"%@",location.timestamp);

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
