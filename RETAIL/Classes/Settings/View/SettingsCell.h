
/******************************************************************************
 *  @file   : SettingsCell.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-16
 *  @brief  : 【设置】页面中的 Cell 视图
 ******************************************************************************/

#import <UIKit/UIKit.h>

#import "DCNumberBubbleView.h"

@interface SettingsCell : UITableViewCell

@property (nonatomic,readonly) UILabel            *titleLabel;
@property (nonatomic,readonly) UISwitch           *onOff;
@property (nonatomic,readonly) DCNumberBubbleView *bubble;

@end
