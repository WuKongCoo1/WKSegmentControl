//
//  WKSegmentControll.h
//  CenturyGuard
//
//  Created by 吴珂 on 15/3/26.
//  Copyright (c) 2015年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKSegmentControl;
@protocol WKSegmentControlDelegate <NSObject>

- (void)segmentControl:(WKSegmentControl *)segmentControl selectedIndex:(NSInteger)index;

@end

@protocol WKSegmentControlDataSource <NSObject>

- (NSString *)segmentControl:(WKSegmentControl *)segmentControl titleOfindex:(NSInteger) index;
- (NSInteger)numberOfButtonInSegmentControl:(WKSegmentControl *)segmentControl;

@end

@interface WKSegmentControl : UIView

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) id<WKSegmentControlDelegate> delegate;
@property (nonatomic, assign) id<WKSegmentControlDataSource> dataSource;

@end
