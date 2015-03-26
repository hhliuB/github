
/******************************************************************************
 *  @file   : SettingsCell.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-16
 *  @brief  : 【设置】页面中的 Cell 视图
 ******************************************************************************/

#import "SettingsCell.h"
#import "CellSelectedBackgroundView.h"

@implementation SettingsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {
    _titleLabel = [self.contentView addLabelWithFrame:CGRectMake(15, 0, 150, 50)
                                                 text:nil
                                            textColor:kDarkTextColor
                                                 font:kDefaultFont];
    
    _onOff = [[UISwitch alloc] initWithFrame:CGRectMake(175, 10, 0, 0)];
    _onOff.onTintColor = kBlueColor;
    [self.contentView addSubview:_onOff];
    
    _bubble = [[DCNumberBubbleView alloc] initWithFrame:CGRectMake(195, 10, 30, 30)];
    _bubble.bubbleColor = kBlueColor;
    _bubble.hidden = YES;
    [self.contentView addSubview:_bubble];
    
    [self.contentView addViewWithFrame:CGRectMake(15, 49, 225, 1)
                       backgroundColor:kDarkGrayColor];
    
    CGRect bounds = CGRectMake(0, 0, 240, 50);
    self.selectedBackgroundView = [CellSelectedBackgroundView defaultViewWithFrame:bounds];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

@end
