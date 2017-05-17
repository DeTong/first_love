//
//  PDFViewController.m
//  FirstLove
//
//  Created by DeTong on 2017/5/17.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()<UIWebViewDelegate>

@property (nonatomic , strong) UIWebView *webView;

@end

@implementation PDFViewController

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"ppp.pdf" withExtension:nil];
        
        NSData *data = [NSData dataWithContentsOfURL:fileURL];
        NSString *base64Encoded = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        NSLog(@"base64Encoded %@",base64Encoded);
        NSData *formBase64String = [[NSData alloc] initWithBase64EncodedString:base64Encoded options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        NSLog(@"datadata %@",data);
//        [_webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
        [_webView loadData:formBase64String MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:nil];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
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
