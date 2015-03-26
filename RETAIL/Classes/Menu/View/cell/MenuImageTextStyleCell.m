
/******************************************************************************
 *  @file   : MenuImageTextStyleCell.m
 *  @author : HAO RUNPENG
 *  @date   : 2014-08-11
 *  @brief  : 【菜单】中的图文混排 cell
 ******************************************************************************/

#import "MenuImageTextStyleCell.h"

@implementation MenuImageTextStyleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 36, 60, 60)];
    _titleLable.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin;
    [self.contentView addSubview:_titleLable];
    
    _menuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 60, 60)];
    _menuImageView.contentMode = UIViewContentModeCenter;
    _menuImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin;
    [self.contentView addSubview: _menuImageView];
    
    _bubble = [[DCNumberBubbleView alloc] initWithFrame:CGRectMake(40, 26, 20, 20)];
    _bubble.font                      = [UIFont systemFontOfSize:14.0];
    _bubble.number                    = 0;
    _bubble.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_bubble];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  self.menuImageView.highlighted = selected;
  self.titleLable.highlighted    = selected;
}

@end
