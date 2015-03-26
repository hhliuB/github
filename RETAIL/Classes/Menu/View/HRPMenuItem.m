
/******************************************************************************
 *  @file   : HRPMenuItem.m
 *  @author : HAO RUNPENG
 *  @date   : 2014-08-12
 *  @brief  : 【菜单】中的功能按钮内容类，用于存储按钮类型及显示内容
 ******************************************************************************/

#import "HRPMenuItem.h"

@interface HRPMenuItem()

@property (nonatomic,readwrite) MenuItemStyle style;

@end

@implementation HRPMenuItem

+ (HRPMenuItem *)menuItemWithStyle:(MenuItemStyle )style
{
  HRPMenuItem *item = [[HRPMenuItem alloc] init];
  item.style = style;
  return item;
}

@end
