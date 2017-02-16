//
//  WordSortingViewController.m
//  FirstLove
//
//  Created by DeTong on 2017/2/16.
//  Copyright © 2017年 DeTong-Geng. All rights reserved.
//

#import "WordSortingViewController.h"

@interface WordSortingViewController ()

@property (nonatomic , strong) NSMutableArray *wordArray;

@end

@implementation WordSortingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.wordArray = [[NSMutableArray alloc] initWithObjects:@"abc",@"bbc",@"acc", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 单词排序 （系统排序方法）
    NSArray *sortWord = [self.wordArray sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@",sortWord);
    
    //  按照升序或者降序排列 (yes 升序 no 降序)
    [self sortWordAscendingOrDescending:YES wordArray:self.wordArray];
    [self sortWordAscendingOrDescending:NO wordArray:self.wordArray];

}

- (NSArray *)sortWord:(NSArray *)arr
{
    NSMutableArray * marr = [NSMutableArray arrayWithArray:arr];
    [marr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        long objLen1 = [obj1 length];
        long objLen2 = [obj2 length];
        long top = objLen1<objLen2 ? objLen1:objLen2;
        for ( int i = 1 ; i < top; i++) {
            NSComparisonResult result = [[obj1 substringWithRange:NSMakeRange(objLen1-i, 1)] compare:[obj2 substringWithRange:NSMakeRange(objLen2-i, 1)]];
            if (result != 0) {
                return result;
            }
        }
        return NSOrderedSame;
    }];
    return marr;
}

- (void)sortWordAscendingOrDescending:(BOOL)isAscending wordArray:(NSArray *)wordArray
{
    //  自定义排序规则
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:nil ascending:isAscending];
    NSArray *sortArray = [wordArray sortedArrayUsingDescriptors:@[sort]];
    NSLog(@"%@",sortArray);
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
