//
//  ViewController.m
//  WKSegmentControl
//
//  Created by 吴珂 on 15/7/7.
//  Copyright (c) 2015年 吴珂. All rights reserved.
//

#import "ViewController.h"
#import "WKSegmentControl.h"

@interface ViewController ()<WKSegmentControlDelegate, WKSegmentControlDataSource>

@property (strong, nonatomic) NSArray *segmentDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKSegmentControl *segmentControl = [[WKSegmentControl alloc] initWithFrame:CGRectMake(20, 40, 200, 40)];
    
    segmentControl.delegate = self;
    segmentControl.dataSource = self;
    
    _segmentDataSource = @[@"家长",@"老师", @"学生", @"教育局"];
    
    [self.view addSubview:segmentControl];
}

#pragma mark - WKSegmentControlDelegate
- (void)segmentControl:(WKSegmentControl *)segmentControl selectedIndex:(NSInteger)index
{
    NSLog(@"selected index : %ld", (long)index);
    
}

- (NSString *)segmentControl:(WKSegmentControl *)segmentControl titleOfindex:(NSInteger) index
{
    return _segmentDataSource[index];
}

- (NSInteger)numberOfButtonInSegmentControl:(WKSegmentControl *)segmentControl
{
    return _segmentDataSource.count;
}

@end
