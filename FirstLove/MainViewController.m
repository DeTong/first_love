//
//  MainViewController.m
//  FirstLove
//
//  Created by ZhaoYu on 16/1/14.
//  Copyright © 2016年 DeTong-Geng. All rights reserved.
//
//  ftp://byu1886910001@byu1886910001.my3w.com/htdocs/php/jsonPhp.php

#import "MainViewController.h"
#import "AFNetworking.h"


@interface MainViewController ()

@property (nonatomic , strong) UIButton *postButton;

@end

@implementation MainViewController


- (UIButton *)postButton
{
    if (!_postButton) {
        _postButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _postButton.center = self.view.center;
        _postButton.backgroundColor = [UIColor blackColor];
        [_postButton setTitle:@"发送请求" forState:UIControlStateNormal];
        [_postButton addTarget:self action:@selector(clickPostButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.postButton];
}

- (void)clickPostButton
{
    //  user_id , user_name , user_pwd  运用其中任一一项关键字 查找用户完全信息
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"iphone" forKey:@"type"];
    [dic setObject:@"searchType" forKey:@"user_name"];
    [dic setObject:@"searchKey" forKey:@"gengdetong"];
    
    NSString *url = @"http://www.tiamobmr.cn/php/jsonPhp.php";

    [[AFHTTPSessionManager manager] POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功 responseObject - %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败 %@",error);
    }];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",response);
        if (data) {
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"string -> %@data -> %@",string,data);
        }
    }];
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
