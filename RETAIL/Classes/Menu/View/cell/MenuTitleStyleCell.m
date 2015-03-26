
/******************************************************************************
 *  @file   : HRPMenuOnlyTitleCell.m
 *  @author : HAO RUNPENG
 *  @date   : 2014-08-12
 *  @brief  : 【菜单】中的纯文本 cell
 ******************************************************************************/

#import "MenuTitleStyleCell.h"

@implementation MenuTitleStyleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 60, 60)];
    _titleLable.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin;
    [self.contentView addSubview:_titleLable];

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
  self.titleLable.highlighted    = selected;
}

@end
