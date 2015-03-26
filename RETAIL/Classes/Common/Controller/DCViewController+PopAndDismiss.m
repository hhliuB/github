
/******************************************************************************
 *  @file   : DCViewController+PopAndDismiss.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-10
 *  @brief  : 用于实现 提交动画 及 dismiss动画 的 DCViewController 扩展
 ******************************************************************************/

#import "DCViewController+PopAndDismiss.h"

#import "MainViewController.h"

@interface DCViewController ()

@property (nonatomic,readonly) MainViewController *mainViewController;

@end

@implementation DCViewController (PopAndDismiss)

- (void)popFromTop
{
  [self popFromTop:nil];
}

- (void)popFromTop:(void (^)())completion
{
  [self.view moveY:-self.view.height completion:^{
    [self.mainViewController popViewController:^{
      self.view.y = 0;
      if (completion) {
        completion();
      }
    }];
  }];
}

- (void)dismiss
{
  [self dismiss:nil];
}

- (void)dismiss:(void (^)())completion
{
  [self.mainViewController dismissViewController:^{
    if (completion) {
      completion();
    }
  }];
}

#pragma mark -
#pragma mark MainViewController

- (MainViewController *)mainViewController
{
  return [MainViewController getInstance];
}

@end
