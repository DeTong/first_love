//
//  KVO_BeenObject.h
//  FirstLove
//
//  Created by DeTong on 2017/3/3.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVO_BeenObject : NSObject

@property (nonatomic , copy) NSString *beenObjectString;
@property (nonatomic , copy) NSString *beenObjectAllString;

- (void)updateKVO_TestBeenObjectString:(NSString *)beenObjectString;

@end
