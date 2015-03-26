
/******************************************************************************
 *  @file   : SettingsProtocol.h
 *  @author : <#author#>
 *  @date   : 2014-09-16
 *  @brief  : 【设置】数据源及代理
 ******************************************************************************/

#import <Foundation/Foundation.h>

@class SettingsViewController;

@interface SettingsProtocol : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,weak) SettingsViewController *controller;

@end
