
/******************************************************************************
 *  @file   : HRPMenuView.h
 *  @author : HAO RUNPENG
 *  @date   : 2014-08-13
 *  @brief  : 【菜单】视图
 ******************************************************************************/

#import "DCView.h"

#import "HRPMenuItem.h"
#import "HRPMenuSettingsItem.h"

@protocol  HRPMenuViewDelegate;

@interface HRPMenuView : DCView

@property (nonatomic)      BOOL                allowsReceiveTouch;

@property (nonatomic,copy) NSArray             *menuItems;
@property (nonatomic)      HRPMenuSettingsItem *settingsItem;

@property (nonatomic)      NSInteger           selectedIndex;

@property (nonatomic,getter = isNormalItemsEnabled)  BOOL normalMenuItemsEnabled;
@property (nonatomic,getter = isSettingsItemEnabled) BOOL settingsItemEnabled;

@property (nonatomic,weak) id<HRPMenuViewDelegate> delegate;

- (void)setBadgeNumber:(NSInteger)badgeNumber atIndex:(NSInteger)index;

- (void)rotateSettingsButtonClockwise:(BOOL)clockwise;

@end


@protocol HRPMenuViewDelegate <NSObject>

@required
- (void)menuViewDidSelectItemAtIndex:(NSInteger)index;

@end
