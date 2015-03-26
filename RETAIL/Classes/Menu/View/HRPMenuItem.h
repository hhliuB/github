
/******************************************************************************
 *  @file   : HRPMenuItem.h
 *  @author : HAO RUNPENG
 *  @date   : 2014-08-12
 *  @brief  : 【菜单】中的功能按钮内容类，用于存储按钮类型及显示内容
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuItemStyle) {
  MenuItemStyleDay,
  MenuItemStyleMonth,
  MenuItemStyleText,
  MenuItemStyleImage,
  MenuItemStyleImageText
};

@interface HRPMenuItem : NSObject

@property (nonatomic,copy) NSString  *title;
@property (nonatomic)      UIImage   *normalImage;
@property (nonatomic)      UIImage   *selectedImage;
@property (nonatomic)      NSInteger badgeNumber;
@property (nonatomic)      UIColor   *selectedColor;

@property(nonatomic,readonly) MenuItemStyle style;

+ (HRPMenuItem *)menuItemWithStyle:(MenuItemStyle )style;

@end
