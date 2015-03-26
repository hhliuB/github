/******************************************************************************
 *  @file   : MainViewController.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-11
 *  @brief  : 主视图控制器，用于布局 SettingsViewController、BaseViewController
 *            以及 push/pop & present/dismiss 视图控制器
 ******************************************************************************/

#import "MainViewController.h"

#import "BaseViewController.h"
#import "SettingsViewController.h"

#import "DCStack2D.h"

@interface MainViewController () <BaseViewControllerDelegate>

@property (nonatomic,readonly) BaseViewController     *baseViewController;
@property (nonatomic,readonly) SettingsViewController *settingsViewController;

@property (nonatomic,strong) DCStack2D *controllerStack;

@property (nonatomic,strong) id didTapCoverObserver;
@property (nonatomic,strong) id didSwipeCoverLeftObserver;
@property (nonatomic,strong) id didSwipeCoverRightObserver;

@property (nonatomic,assign) BOOL isSettingsOpen;

@property (nonatomic,assign) BOOL userInteractionEnabled;

@end

@implementation MainViewController

- (void)dealloc
{
  [self removeNotifications];
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    _controllerStack = [DCStack2D stack2D];
    [_controllerStack pushStack];
    [[_controllerStack topStack] push:self.baseViewController];
    
    [self registerNotifications];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self addChildViewController:self.baseViewController];
}

#pragma mark -
#pragma mark Push & Pop

- (void)pushViewController:(DCViewController *)viewController completion:(void (^)())completion
{
  self.userInteractionEnabled = NO;
  
  UIView *view = viewController.view;
  view.x = 1024 + kSeparatorWidth;
  view.y = 0;
  [self.view addSubview:view];
  
  CGFloat w = view.width + kSeparatorWidth;
  
  DCStack *topStack = [self.controllerStack topStack];
  
  [topStack enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
    DCViewController *controller = obj;
    DCView *existView = (DCView *)controller.view;
    [existView moveX:-w completion:nil];
    [existView fadeInCover];
  }];
  
  [topStack push:viewController];
  
  [view moveX:-w completion:^{
    self.userInteractionEnabled = YES;
    if (completion) {
      completion();
    }
  }];
}

- (void)popViewController:(void (^)())completion
{
  DCStack *topStack = [self.controllerStack topStack];
  if (topStack.length == 1) {
    NSLog(@"*** Cannot pop the view controller which is the last one in the pushed stack.");
    return;
  }
  
  self.userInteractionEnabled = NO;
  
  DCViewController *viewControllerToPop  = [topStack pop];
  DCViewController *viewControllerToShow = [topStack top];
  
  UIView *viewToRemove = viewControllerToPop.view;
  DCView *viewToShow   = viewControllerToShow.view;
  
  [viewToShow fadeOutCover];
  
  CGFloat w = CGRectGetWidth(viewToRemove.bounds) + kSeparatorWidth;
  
  [topStack enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
    DCViewController *controller = obj;
    [controller.view moveX:w completion:nil];
  }];
  
  [viewToRemove moveX:w completion:^{
    [viewToRemove removeFromSuperview];
    [viewControllerToShow didPopBack];
    self.userInteractionEnabled = YES;
    if (completion) {
      completion();
    }
  }];
}

- (void)popViewControllerToTop
{
  if ([self.controllerStack topStack].length > 1) {
    [self popViewController:^{
      [self popViewControllerToTop];
    }];
  }
}

#pragma mark -
#pragma mark Present & Dismiss

- (void)presentViewController:(UIViewController *)viewController completion:(void (^)(void))completion
{
  self.userInteractionEnabled = NO;
  CGFloat h = CGRectGetHeight(self.view.bounds);
  
  UIView *view = viewController.view;
  view.x = 0;
  view.y = h;
  [self.view addSubview:view];
  
  [self.controllerStack pushStack];
  
  DCStack *topStack = [self.controllerStack topStack];
  [topStack push:viewController];
  
  [view moveY:-h completion:^{
    [self.controllerStack enumerateStacksUsingBlock:^(DCStack *stack, BOOL *stop) {
      if (stack != topStack) {
        [stack enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
          DCViewController *viewController = obj;
          DCView *view = viewController.view;
          view.hidden = YES;
        }];
      }
    }];
    
    self.userInteractionEnabled = YES;
    if (completion) {
      completion();
    }
  }];
}

- (void)dismissViewController:(void (^)(void))completion
{
  if (self.controllerStack.length == 1) {
    NSLog(@"*** Cannot dismiss the view controller which is the last one in the presented stack.");
    return;
  }
  
  self.userInteractionEnabled = NO;
  
  DCStack *topStack = [self.controllerStack popStack];
  
  [[self.controllerStack topStack] enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
    DCViewController *viewController = obj;
    DCView *view = viewController.view;
    view.hidden = NO;
  }];
  
  [topStack enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
    DCViewController *controller = obj;
    DCView           *view       = controller.view;
    [view fadeOutCover];
    [view moveY:CGRectGetHeight(self.view.bounds) completion:^{
      [view removeFromSuperview];
      
      DCViewController *viewControllerToShow = [[self.controllerStack topStack] top];
      [viewControllerToShow didDismissBack];
      
      self.userInteractionEnabled = YES;
      
      if (completion) {
        completion();
      }
    }];
  }];
}

#pragma mark -
#pragma mark Notifications

- (void)registerNotifications
{
  NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
  
  if (!self.didTapCoverObserver) {
    self.didTapCoverObserver = [notiCenter addObserverForName:kDCViewCoverDidTapNotification
                                                   usingBlock:^(NSNotification *noti) {
                                                     [self attemptToPopViewController];
                                                   }];
  }
  
  if (!self.didSwipeCoverLeftObserver) {
    self.didSwipeCoverLeftObserver = [notiCenter addObserverForName:kDCViewCoverDidSwipeLeftNotification
                                                         usingBlock:^(NSNotification *noti) {
                                                           [self attemptToPopSettingsViewController];
                                                         }];
  }
  
  if (!self.didSwipeCoverRightObserver) {
    self.didSwipeCoverRightObserver = [notiCenter addObserverForName:kDCViewCoverDidSwipeRightNotification
                                                          usingBlock:^(NSNotification *noti) {
                                                            [self attemptToPopRightViewController];
                                                          }];
  }
}

- (void)removeNotifications
{
  NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
  
  [notiCenter removeObserver:self.didTapCoverObserver];
  self.didTapCoverObserver = nil;
  
  [notiCenter removeObserver:self.didSwipeCoverLeftObserver];
  self.didSwipeCoverLeftObserver = nil;
  
  [notiCenter removeObserver:self.didSwipeCoverRightObserver];
  self.didSwipeCoverRightObserver = nil;
}

- (void)attemptToPopViewController
{
  if (self.isSettingsOpen) {
    [self closeSettings];
  }
  else {
    [self attemptToPopRightViewController];
  }
}

- (void)attemptToPopRightViewController
{
  if ([self.controllerStack topStack].length > 1) {
    DCViewController *controller = [[self.controllerStack topStack] top];
    if ([controller allowsPop]) {
      [self popViewController:nil];
    }
  }
}

- (void)attemptToPopSettingsViewController
{
  if (self.isSettingsOpen) {
    [self closeSettings];
  }
}

#pragma mark -
#pragma mark BaseViewController Delegate

- (void)baseViewControllerDidSelectSettingsMenuItem
{
  [self toggleSettings];
}

#pragma mark -
#pragma mark Settings

- (void)toggleSettings
{
  if (self.isSettingsOpen) {
    [self closeSettings];
  }
  else {
    [self openSettings];
  }
}

- (void)openSettings
{
  self.baseViewController.allowsSwitchModule = NO;
  [self.baseViewController rotateMenuSettingsButtonClockwise:NO];
  
  [self addChildViewController:self.settingsViewController];
  
  UIView *settingsView = self.settingsViewController.view;
  DCView *baseView   = self.baseViewController.view;
  DCView *moduleView = self.baseViewController.currentModuleViewController.view;
  
  CGFloat w = settingsView.width;
  
  [settingsView moveX:w completion:^{
    self.isSettingsOpen = YES;
  }];
  
  [baseView moveX:w completion:nil];
  [moduleView fadeInCover];
}

- (void)closeSettings
{
  self.baseViewController.allowsSwitchModule = YES;
  [self.baseViewController rotateMenuSettingsButtonClockwise:YES];
  
  UIView *settingsView = self.settingsViewController.view;
  DCView *baseView     = self.baseViewController.view;
  DCView *moduleView   = self.baseViewController.currentModuleViewController.view;

  CGFloat w = settingsView.width;
  
  [settingsView moveX:-w completion:^{
    [self.settingsViewController removeFromParentViewController];
    self.isSettingsOpen = NO;
  }];
  
  [baseView moveX:-w completion:nil];
  [moduleView fadeOutCover];
}

#pragma mark -
#pragma mark View Layout

- (CGRect)viewFrameForChildViewController:(DCViewController *)child
{
  if (child == self.baseViewController) {
    return CGRectMake(0, 0, 1024, 768);
  }
  else if (child == self.settingsViewController) {
    return CGRectMake(-kSettingsViewWidth, 0, kSettingsViewWidth, 768);
  }
  
  return CGRectZero;
}

#pragma mark -
#pragma mark Properties

- (BaseViewController *)baseViewController
{
  BaseViewController *controller = [BaseViewController getInstance];
  if (!controller.delegate) {
    controller.delegate = self;
  }
  return controller;
}

- (SettingsViewController *)settingsViewController
{
  return [SettingsViewController getInstance];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
  _userInteractionEnabled = userInteractionEnabled;
  self.view.userInteractionEnabled = userInteractionEnabled;
}

#pragma mark -
#pragma mark Singleton Definition

static id instance = nil;

+ (instancetype)getInstance
{
  @synchronized(self){
    if (!instance) {
      instance = [[self alloc] init];
    }
  }
  
  return instance;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
  @synchronized(self){
    if (!instance) {
      instance = [super allocWithZone:zone];
    }
  }
  
  return instance;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
  return self;
}

@end
