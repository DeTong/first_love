//
//  KVO-BeenObserveViewController.m
//  FirstLove
//
//  Created by DeTong on 2017/3/3.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "KVO-BeenObserveViewController.h"
#import "KVO-ObserveViewController.h"

@interface KVO_BeenObserveViewController ()

@end

@implementation KVO_BeenObserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateKVO_TestString
{
    if (self.kvoTestString) {
        self.kvoTestString = [NSString stringWithFormat:@"%@a",self.kvoTestString];
    }else {
        [self willChangeValueForKey:@"kvoTestString"];
//        如果我们希望只有当bankCodeEn实际被修改时发送通知，以尽量减少不必要的通知，则可以如下实现：
//        。。。
        _kvoTestString = @"使用实例变量直接赋值";
        
        [self didChangeValueForKey:@"kvoTestString"];
//        self.kvoTestString = @"normal";
//        self.kvoTestString = [NSString stringWithFormat:@"a"];
    }
}

//  如果实现手动通知必须重写此方法
//  这个方法返回一个布尔值(默认是返回YES)，以标识参数key指定的属性是否支持自动KVO。如果我们希望手动去发送通知，则针对指定的属性返回NO。
//  http://southpeak.github.io/2015/04/23/cocoa-foundation-nskeyvalueobserving/ 这里说的
//  但是在没有实现此方法的情况下，仍然收到了通知。
//  或许原意是指通过修改set方法而改变的方式，让其关掉自动通知。以免接收到两次同样的通知。（但也不是必须的啊。还是帖子版本有点老呢？）
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    NSLog(@"%@",key);
    return YES;
}

- (void)dealloc
{
    NSLog(@"%@ delloc",self);
//    [self removeObserver:self forKeyPath:@"kvoTestString"];
//    KVO_ObserveViewController *obs = [[KVO_ObserveViewController alloc] init];
//    [obs removeObserver:self forKeyPath:@"kvoTestString"];
    [super dealloc];
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
