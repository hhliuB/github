
/******************************************************************************
 *  @file   : MenuViewController.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-11
 *  @brief  : 【菜单】视图控制器
 ******************************************************************************/

#import "DCViewController.h"

@protocol MenuViewControllerDelegate <NSObject>

@required
- (void)menuViewControllerDidSelectMenuAtIndex:(NSInteger)index;
- (void)menuViewControllerDidSelectSettings;

@end

@interface MenuViewController : DCViewController

@property (nonatomic,weak) id<MenuViewControllerDelegate> delegate;
@property (nonatomic)      BOOL normalMenuItemsEnabled;

- (void)rotateSettingsButtonClockwise:(BOOL)clockwise;

- (void)lock;
- (void)unlock;

+ (instancetype)getInstance;

@end
