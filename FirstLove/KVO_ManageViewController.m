//
//  KVO_ManageViewController.m
//  FirstLove
//
//  Created by DeTong on 2017/3/3.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "KVO_ManageViewController.h"
#import "KVO-ObserveViewController.h"
#import "KVO-BeenObserveViewController.h"
#import "KVO_BeenObject.h"

@interface KVO_ManageViewController ()

@end

@implementation KVO_ManageViewController

static int contextForKVO;   //  这种标识方法应该只适用于观察者为注册的这个类。

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KVO_ObserveViewController *kvoObs = [[KVO_ObserveViewController alloc] init];
    KVO_BeenObserveViewController *kvoBeen = [[KVO_BeenObserveViewController alloc] init];
    KVO_BeenObject *object = [[KVO_BeenObject alloc] init];
    
    [object addObserver:kvoObs forKeyPath:@"beenObjectString" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&contextForKVO];
    [object addObserver:kvoObs forKeyPath:@"beenObjectAllString" options:NSKeyValueObservingOptionNew context:nil];
    
    NSLog(@"执行监听");
    //  延迟1秒钟后在主线程执行代码，但是并不会阻塞主线程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [object updateKVO_TestBeenObjectString:@"beenObjectString"];
        NSLog(@"调用改变方法");
    });
//    利用observationInfo函数，可检查出指定类的监察对象都有哪些。
//    如果移除了某个没有声明的属性，是不是可以利用runtime的获取属性方法然后根据这个方法返回的值来进行一一比较。然后利用运行时的特性，生成相关的属性，或者实例变量？以防止
//    Cannot remove an observer <KVO_ObserveViewController 0x7fb7c7c06c90> for the key path "ksssvoTestString"
//    from <KVO_BeenObserveViewController 0x7fb7c7c06f90> because it is not registered as an observer.'
//    这种情况的发生。
//    NSLog(@"%@",[object observationInfo]);
    
//    NSLog(@"移除监听");
//    [kvoBeen removeObserver:kvoObs forKeyPath:@"kvoTestString"];

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
