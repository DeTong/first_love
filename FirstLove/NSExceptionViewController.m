//
//  NSExceptionViewController.m
//  FirstLove
//
//  Created by DeTong on 2017/2/19.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "NSExceptionViewController.h"
#import "NSObject+Extension.h"

@interface NSExceptionViewController ()

@end

@implementation NSExceptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *exceptionName = @"exceptionName";
    
    NSString *exceptionReason = @"exceptionReason";
    
    NSDictionary *exceptionInfo = @{@"exceptionInfo":@"exceptionInfo"};
    
    NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionInfo];
    
//    if ([[self class] isEqual:[NSExceptionViewController class]]) {
//        @throw exception;
//    }
    //  通过捕获异常来防止程序退出
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    NSString *nilStr = nil;
//    [mutableArray addObject:nilStr];
//    NSLog(@"%@",mutableArray);
    /*
    @try {
        //  如果try里面的代码导致崩溃，就会来到@catch
        //  将一个nil字符串插入到数组中
        [mutableArray addObject:nilStr];
    } @catch (NSException *exception) {
        //  如果要抛出异常，就写上@throw exception
    } @finally {
        //  @finally中的代码是一定会执行的
        //  可以在这里进行一些操作
    }
     */
//    NSLog(@"%@",[mutableArray objectAtIndex:10]);
    
    
    //  利用runtime进行分类的属性添加。如果不利用runtime，但是仍然写了属性的话，是无法生成set，get方法的。虽然能调用出来，但是程序会崩溃。
    NSObject *object = [[NSObject alloc] init];
//    [object setTestString:@"你好,小马哥！"];
//    NSLog(@"%@",[object testString]);
//    object.testString = @"小马哥就是你啊！";
    NSLog(@"%@",object.testString);
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
