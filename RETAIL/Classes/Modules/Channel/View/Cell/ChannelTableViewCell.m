//
//  ChannelTableViewCell.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/19.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ChannelTableViewCell.h"

@implementation ChannelTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
  if (selected) {
    self.textLabel.highlighted = YES;
  }
  else {
    self.textLabel.highlighted = NO;
  }
}

@end
