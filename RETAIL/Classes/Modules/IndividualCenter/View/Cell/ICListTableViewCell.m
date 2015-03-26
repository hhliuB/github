//
//  ICListTableViewCell.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICListTableViewCell.h"

@implementation ICListTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];

  if (selected) {
    self.textLabel.textColor = kMainColor;
  }
  else {
    self.textLabel.textColor = kTextColor;
  }
}

@end
