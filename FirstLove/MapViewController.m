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

@property (nonatomic , copy) NSString *abc;
@property (nonatomic , strong) CLGeocoder *geocoder;

@end

@implementation MapViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.abc = @"abc";
    }
    return self;
}

- (CLGeocoder *)geocoder
{
     if (_geocoder==nil) {
         _geocoder=[[CLGeocoder alloc]init];
     }
     return _geocoder;
}


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

//    if ([self.abc isEqualToString:@"abc"])
//        NSLog(@"1");
//    else
//        NSLog(@"3");
//    
//    NSLog(@"2");
    
    
    //      系统自带的地理编码 与 反地理编码
    /**
     *  地名转换成经纬度
     */
//    [self.geocoder geocodeAddressString:@"大福海鲜烧烤" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"error - %@",error);
//        }
//        NSLog(@"%ld",placemarks.count);
//        CLPlacemark *firstPlacemark=[placemarks firstObject];
//        NSLog(@"%@",firstPlacemark.name);
//        NSLog(@"纬度：%f 经度： %f",firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude);
//    }];
    
    /**
     *  经纬度转换成地名
     */
    //  首先制作一个经纬度
//    CLLocationCoordinate2D *location = CLLocationCoordinate2DMake(41.674263, 123.350014);
    CLLocationDegrees latitude = 39.977338;
    CLLocationDegrees longitude = 116.329855;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%lu",placemarks.count);
        CLPlacemark *reversePlacemark = placemarks.firstObject;
        
        NSLog(@"%@",reversePlacemark.name);
    }];
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
