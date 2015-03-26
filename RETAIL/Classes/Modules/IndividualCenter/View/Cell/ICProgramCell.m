//
//  ICProgramCell.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/23.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICProgramCell.h"

@implementation ICProgramCell

- (instancetype)init
{
  self = [super init];
  if (self) {
    _iconImage = [self.contentView addViewWithFrame:CGRectMake(10, 10, 200, 200) class:[UIImageView class] backgroundColor:kBlueColor];
    
    UIView *coverView = [self.contentView addViewWithFrame:CGRectMake(10, 210, 200, 50) class:[UIView class] backgroundColor:kWhiteColor];
    _titleLabel = [coverView addLabelWithFrame:CGRectMake(10, 5, 180, 20) text:@"撒娇女人最好命" textColor:kTextColor font:kLargestFont];
    
    _percentageLabel = [coverView addLabelWithFrame:CGRectMake(10, 30, 180, 20) text:@"已观看 90%" textColor:kTextColor font:kLargerFont];
  }
  
  return self;
}

@end
