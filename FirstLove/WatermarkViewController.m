//
//  WatermarkViewController.m
//  FirstLove
//
//  Created by DeTong on 2017/3/31.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "WatermarkViewController.h"
#import "UIImageView+Addition.h"

@interface WatermarkViewController ()

@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , strong) UIImageView *watermarkImageView;

@end

@implementation WatermarkViewController

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _imageView.backgroundColor = [UIColor yellowColor];
        _imageView.image = [UIImage imageNamed:@"IMG_0062.JPG"];
    }
    return _imageView;
}

- (UIImageView *)watermarkImageView
{
    if (!_watermarkImageView) {
        _watermarkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 250, 330)];
        _watermarkImageView.backgroundColor = [UIColor redColor];
//        _watermarkImageView.image = [ImageAddWatermark imageAddWatermarkWithText:@"慢慢-张学友" image:self.imageView.image];
        [_watermarkImageView setImage:self.imageView.image withStringWaterMark:@"化身为龙" inRect:CGRectMake(0 , 0 , 100 , 20) color:[UIColor yellowColor] font:[UIFont systemFontOfSize:30.0]];
    }
    return _watermarkImageView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.watermarkImageView];
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
