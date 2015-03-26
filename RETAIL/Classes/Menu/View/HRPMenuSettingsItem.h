
/******************************************************************************
 *  @file   : HRPMenuSettingsItem.h
 *  @author : HAO RUNPENG
 *  @date   : 2014-08-14
 *  @brief  : 【菜单】中的设置按钮内容类
 *            用于存储按钮显示内容 和 点击后的响应对象及方法
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HRPMenuSettingsItem : NSObject

@property (nonatomic) UIImage *normalImage;
@property (nonatomic) UIImage *selectedImage;

@property (nonatomic) id  target;
@property (nonatomic) SEL action;

@end
