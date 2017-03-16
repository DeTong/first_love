//
//  UICollectionDemoViewController.m
//  FirstLove
//
//  Created by DeTong on 2017/3/9.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "UICollectionDemoViewController.h"
#import "DemoCollectionViewCell.h"
#import "DemoFlowLayout.h"

#define SCREEN_BOUNDS    [[UIScreen mainScreen] bounds]                   // 设备的宽和高
#define VIEW_WIDTH       SCREEN_BOUNDS.size.width                         // 设备的宽
#define VIEW_HEIGHT      SCREEN_BOUNDS.size.height                        // 设备的高

#define ITEM_GAP         0.5
#define ITEM_COUNT       4


@interface UICollectionDemoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView *collectionView;

@end

@implementation UICollectionDemoViewController

static NSString *const demoCellId = @"DemoCollectionViewCell";

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        /*
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        collectionLayout.minimumLineSpacing = 0.0;       //  行与行之间的空隙
        collectionLayout.minimumInteritemSpacing = 0.0;       //  条目之间的空隙
         */
        DemoFlowLayout *demoLayout = [[DemoFlowLayout alloc] init];
                                                        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, VIEW_WIDTH, 300) collectionViewLayout:demoLayout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:demoCellId];
    }
    return _collectionView;
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:demoCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
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
