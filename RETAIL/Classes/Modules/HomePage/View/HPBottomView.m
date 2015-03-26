
//
//  HPBottomView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/18.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "HPBottomView.h"

@implementation HPBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = kBlueColor;
    self.scrollerHeight = 80;
    self.numberOfTag = 0;
  }
  return self;
}

- (void)creatScrollerView
{
  [self removeSubviews];
  if ([self.delegate respondsToSelector:@selector(numberOfscrollerViewInBottomtView)]) {
    NSInteger index = [self.delegate numberOfscrollerViewInBottomtView];
    CGFloat y = 0;
    for (int i = 0; i < index; i++) {
      if ([self.delegate respondsToSelector:@selector(bottomView:greatScrollerViewInBottomView:)]) {
        CGFloat headerHeight = [self.delegate bottomView:self heightForHeaderInIndex:i];
        if ([self.delegate respondsToSelector:@selector(bottomView:headerOfScrollerViewInIndex:)]) {
          UIView *headerView = [self.delegate bottomView:self headerOfScrollerViewInIndex:i];
          [headerView setFrame:CGRectMake(0, y, self.width, headerHeight)];
          y += headerHeight;
          [self addSubview:headerView];
        }
      }
      UITableView *tableView = [self.delegate bottomView:self greatScrollerViewInBottomView:i];
      [tableView setFrame:CGRectMake(0, y, self.width, self.scrollerHeight)];
      CGPoint pointCenter = tableView.center;
      
      //tableViews.contentOffset = CGPointMake(0, 320);
      //[tableViews.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
      //tableview逆时针旋转90度。
      
      tableView.transform = CGAffineTransformMakeRotation(-M_PI /2);
      tableView.frame = CGRectMake(0, y, self.width, self.scrollerHeight);
      tableView.center = pointCenter;
      
      y += self.scrollerHeight;
      [self addSubview:tableView];
    }
  }
}

- (void)reloadData
{
  [self creatScrollerView];
}

@end
