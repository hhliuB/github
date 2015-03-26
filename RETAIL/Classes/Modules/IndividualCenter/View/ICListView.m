//
//  ICListView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICListView.h"

@implementation ICListView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _iconView = [self addViewWithFrame:CGRectMake((kLeftViewWidth - 100) / 2, 20, 100, 100) class:[UIImageView class] backgroundColor:kLightGrayColor];
    _iconView.layer.cornerRadius = 50;
    
    _iconBorderView = [self addViewWithFrame:CGRectMake((kLeftViewWidth - 120) / 2, 10, 120, 120) class:[UIImageView class] backgroundColor:kClearColor];
    _iconBorderView.image = [UIImage imageNamed:@"icon_border"];
    
    _titleLabel = [self addLabelWithFrame:CGRectMake((kLeftViewWidth - 100) / 2, 130, 100, 30) text:@"点击头像登录" textColor:kTextColor font:kLargerFont];
    
    _tableView = [self addViewWithFrame:CGRectMake(20, 170, 200, self.height - 175) class:[UITableView class] backgroundColor:kLightGrayColor];
    _tableView.rowHeight     = 60;
    _tableView.scrollEnabled = NO;
  }
  return self;
}

@end
