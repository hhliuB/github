//
//  ICDefinitionCell.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/23.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICDefinitionCell.h"

@implementation ICDefinitionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.textLabel.textColor = kTextColor;
    self.textLabel.font      = kDefaultFont;
    
    self.accessoryType  = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
  if (selected) {
    self.textLabel.textColor = kMainColor;
    self.accessoryType       = UITableViewCellAccessoryCheckmark;
  }
  else {
    self.textLabel.textColor = kTextColor;
    self.accessoryType       = UITableViewCellAccessoryNone;
  }

}

@end
