/******************************************************************************
 *  @file   : MainViewController.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-11
 *  @brief  : 主视图控制器，用于布局 SettingsViewController、BaseViewController
 *            以及 push/pop & present/dismiss 视图控制器
 ******************************************************************************/

#import "DCViewController.h"

@interface MainViewController : DCViewController

- (void)pushViewController:(DCViewController *)viewController completion:(void (^)())completion;
- (void)popViewController:(void (^)())completion;

- (void)popViewControllerToTop;

- (void)presentViewController:(UIViewController *)viewController
                   completion:(void (^)(void))completion;
- (void)dismissViewController:(void (^)(void))completion;

+ (instancetype)getInstance;

@end

@interface MainViewController (UNAVAILABLE_FUNCTIONS)

- (void)presentViewController:(UIViewController *)viewControllerToPresent
                     animated:(BOOL)flag
                   completion:(void (^)(void))completion UNAVAILABLE_ATTRIBUTE;

- (void)dismissViewControllerAnimated:(BOOL)flag
                           completion:(void (^)(void))completion UNAVAILABLE_ATTRIBUTE;

@end
