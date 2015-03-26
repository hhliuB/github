//
//  HPHeaderView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/17.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "HPHeaderView.h"

@implementation HPHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    _myButton      = [self addButtonWithFrame:CGRectMake(780, 20, 70, 30)];
//    _searchButton  = [self addButtonWithFrame:CGRectMake(780, 20, 70, 30)];
    _historyButton = [self addButtonWithFrame:CGRectMake(870, 20, 70, 30)];
    
    [_myButton      setBackgroundColor:kBlueColor];
//    [_searchButton  setBackgroundColor:kBlueColor];
    [_historyButton setBackgroundColor:kBlueColor];
    
    [_myButton      setTitle:@"个人" forState:UIControlStateNormal];
//    [_searchButton  setTitle:@"搜索" forState:UIControlStateNormal];
    [_historyButton setTitle:@"历史" forState:UIControlStateNormal];

    [self addLabelWithFrame:CGRectMake(20, 20, 400, 30) text:@"基于iOS平台的视频播放系统" textColor:kTextColor font:kLargestFont];
  }
  return self;
}

@end
