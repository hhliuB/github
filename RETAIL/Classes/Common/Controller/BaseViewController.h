/******************************************************************************
 *  @file   : BaseViewController.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-22
 *  @brief  : 布局 MenuViewController 及 各功能控制器
 ******************************************************************************/

#import "DCViewController.h"

@protocol BaseViewControllerDelegate <NSObject>

@required
- (void)baseViewControllerDidSelectSettingsMenuItem;

@end

@interface BaseViewController : DCViewController

@property (nonatomic,weak)     id<BaseViewControllerDelegate> delegate;
@property (nonatomic,readonly) DCViewController *currentModuleViewController;
@property (nonatomic)          BOOL              allowsSwitchModule; // Default is YES.

- (void)rotateMenuSettingsButtonClockwise:(BOOL)clockwise;

+ (instancetype)getInstance;

@end
