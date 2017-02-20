//
//  NSMutableArray+Extension.m
//  FirstLove
//
//  Created by DeTong on 2017/2/19.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>


@implementation NSMutableArray (Extension)

+ (void)load
{
    //  利用runtime进行方法替换
    Class arrayClass = NSClassFromString(@"__NSArrayM");
    
    //  获取系统的添加元素方法
    Method addObject = class_getInstanceMethod(arrayClass, @selector(addObject:));
    //  获取自定义的添加元素方法
    Method avoidCrashAddObject = class_getInstanceMethod(arrayClass, @selector(avoidCrashAddObject:));
    //将两个方法进行交换
    //当你调用addObject,其实就是调用avoidCrashAddObject
    //当你调用avoidCrashAddObject，其实就是调用addObject
    method_exchangeImplementations(addObject, avoidCrashAddObject);
    
    Method objectIndex = class_getInstanceMethod(arrayClass, @selector(objectAtIndex:));
    Method avoidCrashObjectIndex = class_getInstanceMethod(arrayClass, @selector(avoidCrashObjectIndex:));
    method_exchangeImplementations(objectIndex, avoidCrashObjectIndex);
}

- (void)avoidCrashAddObject:(id)anObject
{
    @try {
        [self avoidCrashAddObject:anObject];    //  通过runtime方法调换之后其实调用的是addobject方法
    } @catch (NSException *exception) {

        //  能来到这里，说明添加数据异常
        NSLog(@"exception.name%@,exception.reason%@,exception.userInfo%@",exception.name,exception.reason,exception.userInfo);
        //  增加处理方法
        if (!anObject) {
            [self addObject:@""];
        }
    } @finally {
    }
}

- (id)avoidCrashObjectIndex:(NSUInteger)index
{
    //  有返回值的函数，要注意返回值
    id object = nil;
    @try {
        object = [self avoidCrashObjectIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"exception.name%@,exception.reason%@,exception.userInfo%@",exception.name,exception.reason,exception.userInfo);
        //  默认处理方法
        object = @"超出范围，取值失败";
    } @finally {
        return object;
    }
}

@end
