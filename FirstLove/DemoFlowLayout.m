//
//  DemoFlowLayout.m
//  FirstLove
//
//  Created by DeTong on 2017/3/9.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "DemoFlowLayout.h"

#define SCREEN_BOUNDS    [[UIScreen mainScreen] bounds]                   // 设备的宽和高
#define VIEW_WIDTH       SCREEN_BOUNDS.size.width                         // 设备的宽
#define VIEW_HEIGHT      SCREEN_BOUNDS.size.height                        // 设备的高

#define ITEM_GAP         0.5
#define ITEM_COUNT       4

@implementation DemoFlowLayout

//  布局的初始化操作
- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake((VIEW_WIDTH - (ITEM_GAP * ITEM_COUNT)) / 4 , 60);
    self.minimumLineSpacing = 0.0;
    self.minimumInteritemSpacing = 0.0;
    self.sectionInset = UIEdgeInsetsMake(ITEM_GAP, ITEM_GAP, ITEM_GAP, ITEM_GAP);
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath

//  对item的样式封装成UICollectionViewLayoutAttributes类型，以数组的形式返回
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* attributes = [[super layoutAttributesForElementsInRect:rect] copy];
    
//    for (UICollectionViewLayoutAttributes *attr in attributes) {
//        attr.size = CGSizeMake(60, arc4random()%20 + 20);
//    }
//    return attributes;
    return [super layoutAttributesForElementsInRect:rect];
}

@end
