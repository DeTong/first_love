//
//  NSObject+Extension.m
//  FirstLove
//
//  Created by DeTong on 2017/2/19.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>


@implementation NSObject (Extension)


//  根据runtime为分类绑定set方法已经get方法。绑定的key写法是根据afnetworking来做的。看网上都是直接写个char
- (NSString *)testString
{
//    id obj = objc_getAssociatedObject(self, @selector(testString));
//    if (!obj) {
//        return @"";
//    }
//    return obj;
    return objc_getAssociatedObject(self, @selector(testString));
}

- (void)setTestString:(NSString *)testString
{
    objc_setAssociatedObject(self, @selector(testString), testString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
