//
//  HPHeaderSegmentButtonProtocol.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/18.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "HPHeaderSegmentButtonProtocol.h"

@implementation HPHeaderSegmentButtonProtocol

- (void)segmentButton:(DCSegmentButton *)segmentButton didSelectIndex:(NSInteger)index
{
  switch (index) {
    case 0:
      [self.controller showRecommentTableView]; break;
     case 1:
      [self.controller showHitTableView];       break;
  }
}

@end
