//
//  WKSegmentControll.m
//  CenturyGuard
//
//  Created by 吴珂 on 15/3/26.
//  Copyright (c) 2015年 sjyt. All rights reserved.
//

#import "WKSegmentControl.h"

#ifndef RGB
#define RGB(r, g, b) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f]
#endif

#define defaultBtnNum 2
@implementation WKSegmentControl
{
    UIButton *_selectedBtn;
    BOOL isAwakeFromNib;
    BOOL isInitWithFrame;
}
- (void)awakeFromNib
{
    isAwakeFromNib = YES;
}

- (void)layoutSubviews
{
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = RGB(36, 172, 194).CGColor;
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    

    if (isAwakeFromNib) {
        isAwakeFromNib = NO;
        [self setupUI];
    }else if(isInitWithFrame){
        isInitWithFrame = NO;
        [self setupUI];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isInitWithFrame = YES;
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setupBtn:(UIButton *)btn
{
    [btn setBackgroundImage:[UIImage imageNamed:@"info_bg"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"header"] forState:UIControlStateSelected];
    
    [btn setTitleColor:RGB(54, 171, 191) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    if ([self.dataSource respondsToSelector:@selector(segmentControl:titleOfindex:)]) {
        [btn setTitle:[self.dataSource segmentControl:self titleOfindex:btn.tag] forState:UIControlStateNormal];
    }else{
        [btn setTitle:[NSString stringWithFormat:@"%ld", btn.tag] forState:UIControlStateNormal];
    }
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction:(UIButton *)btn
{
    if (btn != _selectedBtn) {
        _selectedBtn.selected = NO;
        btn.selected = YES;
        _selectedBtn = btn;
        
        if ([self.delegate respondsToSelector:@selector(segmentControl:selectedIndex:)]) {
            [self.delegate segmentControl:self selectedIndex:btn.tag];
            self.selectedIndex = btn.tag;
        }
    }
}

- (void)setDataSource:(id<WKSegmentControlDataSource>)dataSource
{
    _dataSource = dataSource;
   

}

- (void)setupUI
{
    NSInteger btnNum;
    if ([self.dataSource respondsToSelector:@selector(numberOfButtonInSegmentControl:)]) {
        btnNum = [self.dataSource numberOfButtonInSegmentControl:self];
    }else{
        btnNum = defaultBtnNum;
    }
    CGFloat btnWidth = self.frame.size.width / btnNum;
    
    for (int i = 0; i < btnNum; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, self.frame.size.height);
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setupBtn:btn];
        //设置边界线
        UIView *leftBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
        
        leftBorderLine.backgroundColor = RGB(36, 172, 194);
        [btn addSubview:leftBorderLine];
        if (i == _selectedIndex) {
            btn.selected = YES;
            _selectedBtn = btn;
        }
        [self addSubview:btn];
    }

}

@end
