
/******************************************************************************
 *  @file   : MenuImageTextStyleCell.h
 *  @author : HAO RUNPENG
 *  @date   : 2014-08-11
 *  @brief  : 【菜单】中的图文混排 cell
 ******************************************************************************/

#import <UIKit/UIKit.h>
#import "DCNumberBubbleView.h"

@interface MenuImageTextStyleCell : UITableViewCell

@property (nonatomic) UIImageView        *menuImageView;
@property (nonatomic) UILabel            *titleLable;
@property (nonatomic) DCNumberBubbleView *bubble;

@end
