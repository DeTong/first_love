//
//  KVO-ObserveViewController.m
//  FirstLove
//
//  Created by DeTong on 2017/3/3.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "KVO-ObserveViewController.h"
#import "KVO-BeenObserveViewController.h"

@interface KVO_ObserveViewController ()

@end

@implementation KVO_ObserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"change : %@\n keyPath : %@\n context : %p",change,keyPath,context);
}

- (void)dealloc
{
    KVO_BeenObserveViewController *been = [[KVO_BeenObserveViewController alloc] init];
    [been removeObserver:self forKeyPath:@"kvoTestString"];
    NSLog(@"dealloc %@",self);
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
