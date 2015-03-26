//
//  HPConrentView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/17.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "HPContentView.h"

@implementation HPContentView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    CGFloat width = self.width;
    
    _segmentButton      = [[DCSegmentButton alloc] initWithFrame:CGRectMake((width - 300) / 2, 10, 300, 30)
                                                           style:DCSegmentButtonStyleRoundRect
                                                          titles:@[@"推荐", @"热播"]];
    [self addSubview:_segmentButton];

//    _recommentTableView = [self addViewWithFrame:CGRectMake(0, 50, self.width, 1000)
//                                           class:[UITableView class]
//                                 backgroundColor:kClearColor];
//    _hitTableView       = [self addViewWithFrame:CGRectMake(self.width, 50, self.width, 1000)
//                                           class:[UITableView class]
//                                 backgroundColor:kClearColor];
//    
//    _recommentTableView.rowHeight      = 200;
//    _recommentTableView.scrollEnabled  = NO;
//    _recommentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _recommentTableView.showsHorizontalScrollIndicator = NO;
//
//    
//    _hitTableView.rowHeight      = 200;
//    _hitTableView.scrollEnabled  = NO;
//    _hitTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _hitTableView.showsHorizontalScrollIndicator = NO;
    
    _bottomView = [self addViewWithFrame:CGRectMake(0, 50, self.width, 1000)
                                   class:[HPBottomView class]
                         backgroundColor:kGrayColor];
    _bottomView.scrollerHeight = 200;
  }
  return self;
}

@end
