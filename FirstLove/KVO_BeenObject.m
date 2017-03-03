//
//  KVO_BeenObject.m
//  FirstLove
//
//  Created by DeTong on 2017/3/3.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "KVO_BeenObject.h"

@implementation KVO_BeenObject

- (void)updateKVO_TestBeenObjectString:(NSString *)beenObjectString
{
    [self willChangeValueForKey:@"beenObjectString"];
//    _beenObjectString = @"use _beenObjectString change value";
    self.beenObjectString = beenObjectString;
    [self didChangeValueForKey:@"beenObjectString"];
}

//  新建一个属性，其返回值是包含其它属性的。这种产生了依赖关系的变化，当被依赖的属性修改之后，也会发送修改新建属性的通知。
//  我们还可以实现一个命名为keyPathsForValuesAffecting\<Key\>的类方法来达到同样的目的，
//  其中<Key>是我们计算属性的名称。所以对于accountForBank属性，还可以如下实现：
//  建议使用后面一种方法，这种方法让依赖关系更加清晰明了
+ (NSSet *)keyPathsForValuesAffectingBeenObjectAllString
{
    return [NSSet setWithObjects:@"beenObjectString", nil];
}

- (NSString *)beenObjectAllString
{
    return [NSString stringWithFormat:@"beenObjectAllString + %@",self.beenObjectString];
}


//  对于并不是直接修改set属性的情况，是否自动发送通知
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    NSLog(@"key :%@ isAuto :%d",key,[super automaticallyNotifiesObserversForKey:key]);
    if ([key isEqualToString:@"beenObjectString"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}


@end
