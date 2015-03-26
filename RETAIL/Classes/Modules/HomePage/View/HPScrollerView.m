//
//  HPScrollerView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/17.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "HPScrollerView.h"

@implementation HPScrollerView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _scrollerView = [self addScrollviewWithFrame:CGRectMake(0, 0, self.width, self.height)
                                     contentSize:CGSizeMake(0, 275)];
  }
  return self;
}

@end
