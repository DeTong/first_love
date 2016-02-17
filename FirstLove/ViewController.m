//
//  ViewController.m
//  FirstLove
//
//  Created by ZhaoYu on 16/1/14.
//  Copyright © 2016年 DeTong-Geng. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

#import "zlib.h"

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
    //  压缩请求内容
    [request addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    NSData *compressed = [self compressNSData:data];
    [request setHTTPBody:compressed];
    //  对请求开启管道支持
//    [request setHTTPShouldUsePipelining:YES];
    //  request的缓存处理
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    //  配置NSURLCache    1MB的内存缓存 24MB的持久化缓存 缓存数据库的位置位于应用的沙盒，在Library/Caches 目录下，文件名为URLCache
//    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:1024 * 1024 diskCapacity:1024 * 1024 * 24 diskPath:@"URLCache"];
//    [NSURLCache setSharedURLCache:cache];

    
    /**
     *  系统提供的几种缓存策略
     */
//    typedef NS_ENUM(NSUInteger, NSURLRequestCachePolicy) {
//        /**
//         *  默认策略
//         */
//        NSURLRequestUseProtocolCachePolicy = 0,
//        /**
//         *  请求略过本地缓存，从网络上检索新的内容。如果某些网络设备介于应用于数据源之间，并且持有内容的缓存副本，就会返回缓存副本。
//         */
//        NSURLRequestReloadIgnoringLocalCacheData = 1,
//        /**
//         *  请求略过本地缓存并将头添加到请求中，同时中间设备也略过缓存，提供原服务器上的最新数据。
//         */
//        NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4,
//        // Unimplemented NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData,
//        /**
//         *  返回一份内容的缓存副本而不去验证服务器上是否有最新的副本。如果请求的缓存副本在缓存中存在，就将其返回。如果缓存副本不存在，那就通过网络请求检索内容。
//         *  该设置提供了最快的响应时间，但却最有可能返回过期的数据。要想通过该设置带来收益，请使用该类型的请求想用户提供最初的快速响应，然后在后台线程中发出请求，使用服务器的最新数据来刷新缓存。
//         */
//        NSURLRequestReturnCacheDataElseLoad = 2,
//        /**
//         *  只返回缓存中的内容，如果内容不在缓存中，那就会返回错误而不是从服务器上获取内容。
//         */
//        NSURLRequestReturnCacheDataDontLoad = 3,
//        /**
//         *  总是会重新验证数据。在某些情况下，缓存的响应可能会有过期时间，到了这个时间后系统就会检查最新的数据。如果使用该设置，那就会忽略掉过期的时间，并且总是验证服务器有没有最新的内容。
//         */
//        NSURLRequestReloadRevalidatingCacheData = 5,        // Unimplemented    未实现的。
//    };

    
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

//  创建NSOperationQueue
- (void)createNSOperationQueue
{
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(createCookie) object:nil];
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation");
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:invocationOperation];
    [queue addOperation:blockOperation];
}

/**
 *  压缩请求体
 *
 *  @param myData 被压缩数据
 *
 *  @return 压缩之后的数据
 */
- (NSData *)compressNSData:(NSData *)myData
{
    NSMutableData *compressedData = [NSMutableData dataWithLength:16384];
    
    z_stream compressiongStream;
    //  设置compressiongStream
    compressiongStream.next_in = (Bytef *)[myData bytes];   //  被压缩源字符串
//    compressiongStream.next_out   //  设置后字符串的存放缓冲区
    compressiongStream.avail_in = (int)[myData length];     //  被压源字符串的长度
    compressiongStream.zalloc = Z_NULL;
    compressiongStream.zfree = Z_NULL;
    compressiongStream.opaque = Z_NULL;
    compressiongStream.total_out = 0;                       //  压缩后字符串的最大长度
    
    //  start the compression of the stream using default compression   开始使用默认压缩流压缩
    if (deflateInit2(&compressiongStream, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15 + 16), 8, Z_DEFAULT_STRATEGY) != Z_OK) {
        //  压缩出错
//        errorOccurred = YES;
        return nil;
    }
    //  循环写输出流
    do {
        //  for every 16k of data compress a chunk into
        //  the compressedData buffer
        if (compressiongStream.total_out >= [compressedData length]) {
            // increase the size of the output data buffer  增加输出数据缓冲区的大小
            [compressedData increaseLengthBy:16386];
        }
        
        compressiongStream.next_out = [compressedData mutableBytes] + compressiongStream.total_out;
        compressiongStream.avail_out = (int)([compressedData length] + compressiongStream.total_out);
        
        //  compress the next chunk of data
        deflate(&compressiongStream, Z_FINISH);
        //  keep going until no more compressed data to copy out    保持继续，直到没有更多的压缩数据复制
    } while (compressiongStream.avail_out == 0);
    
    //  end the compression run
    deflateEnd(&compressiongStream);
    
    //  set the actual length of the compressed data object     设置压缩数据对象的实际长度
    //  to match the number of bytes    匹配字节数
    //  returned by the compression stream      返回压缩流
    [compressedData setLength:compressiongStream.total_out];
    
    return compressedData;
}

- (void)socket
{
    //初始化socket
//    socket(<#int#>, <#int#>, <#int#>)
//    bind(<#int#>, <#const struct sockaddr *#>, <#socklen_t#>)
    
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
