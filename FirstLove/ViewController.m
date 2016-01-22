//
//  ViewController.m
//  FirstLove
//
//  Created by ZhaoYu on 16/1/14.
//  Copyright © 2016年 DeTong-Geng. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (copy, nonatomic) NSString *urlString;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        self.urlString = @"http://www.tiamobmr.cn/php/jsonPhp.php";
        self.urlString = @"http://api.3g.ifeng.com/channel_list_ios?channel=origin&pageindex=1&pagesize=1";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createCookie];
}
- (IBAction)clickSystemButton:(id)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"i" forKey:@"type"];
    [dic setObject:@"searchType" forKey:@"user_name"];
    [dic setObject:@"searchKey" forKey:@"gengdetong"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    //  明确指定url请求不使用cookie
//    request.HTTPShouldHandleCookies = NO;
    //  请求方式
//    request.HTTPMethod = @"POST";
    //  请求参数
//    request.HTTPBody = data;
    //  添加请求头 application/json将请求流格式设置为json
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //  删除请求头(其实就是把值设置为空)
//    [request setValue:@"" forHTTPHeaderField:@"Content-Type"];

    
    //  默认不应使用mainqueue
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",response);
        //  将response（NSURLResponse） 强制转换为NSHTTPURLResponse类型。以便获取请求头信息
        if (response) {
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
            NSLog(@"%@",urlResponse.allHeaderFields);
            NSLog(@"%ld",(long)urlResponse.statusCode);
            
            //  获取cookie
            NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:urlResponse.allHeaderFields forURL:response.URL];
            for (NSHTTPCookie *cookie in cookies) {
                NSLog(@"\n cookies:%@",cookie);
            }
        }
        
//        if (data) {
//            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"string -> %@",string);
//        }
    }];

    
}

//  删除所有cookie
- (void)deleteAllCookie
{
    //  获取cookie单例
    NSHTTPCookieStorage *jar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //  获取所有cookie
    NSArray *storedCookies = [jar cookies];
    //  删除所有cookie
    for (NSHTTPCookie *cookie in storedCookies) {
        [jar deleteCookie:cookie];
    }
    //  保存删除结果
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  根据指定url的cookie名称删除cookie
- (void)deleteCookie:(NSString *)cookieName url:(NSURL *)url
{
    NSHTTPCookieStorage *jar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *storedCookies = [jar cookies];
    
    for (NSHTTPCookie *cookie in storedCookies) {
        if ([[cookie name] isEqualToString:cookieName]) {
            [jar deleteCookie:cookie];
        }
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//  创建cookie
- (void)createCookie
{
    /**
     *  第一种方式(添加到指定url里)
     */
    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:@"FOO",NSHTTPCookieName,
                                                                          @"This is foo",NSHTTPCookieValue,
                                                                          @"/",NSHTTPCookiePath,
                                [NSURL URLWithString:self.urlString],NSHTTPCookieOriginURL, nil];
    //  根据描述的特性创建cookie
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:properties];
    //  创建一个可变的请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    //  创建包含一个cookie的数组
    NSArray *newCookies = [NSArray arrayWithObject:cookie];
    //  创建一个包含新cookie信息的头信息（header）
    NSDictionary *newHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:newCookies];
    //  将新建的cookie添加到请求头里
    [request setAllHTTPHeaderFields:newHeaders];
    //  发送请求
    NSURLResponse *response;
    NSError *error;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    /**
     *  第二种方式(将cookie添加到之后所有的请求里)
     */
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (IBAction)clickAFNetButton:(id)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"i" forKey:@"type"];
    [dic setObject:@"searchType" forKey:@"user_name"];
    [dic setObject:@"searchKey" forKey:@"gengdetong"];
    
    [[AFHTTPSessionManager manager] POST:self.urlString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功 responseObject - %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败 %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
