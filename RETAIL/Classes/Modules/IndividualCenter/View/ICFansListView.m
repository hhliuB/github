//
//  ICFansListView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICFansListView.h"

// 粉丝列表

@implementation ICFansListView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _tableView = [self addViewWithFrame:self.bounds class:[UITableView class] backgroundColor:kClearColor];
    _tableView.rowHeight = 90;
  }
  return self;
}

@end
