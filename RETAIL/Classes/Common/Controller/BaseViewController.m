/******************************************************************************
 *  @file   : BaseViewController.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-22
 *  @brief  : 布局 MenuViewController 及 各功能控制器
 ******************************************************************************/

#import "BaseViewController.h"
#import "MenuViewController.h"

#import "ModuleConstants.h"

@interface BaseViewController () <MenuViewControllerDelegate>

@property (nonatomic,strong) MenuViewController *menuViewController;
@property (nonatomic,assign) NSInteger currentModuleIndex;

@property (nonatomic,strong) NSMutableDictionary *moduleViewControllers;

@end

@implementation BaseViewController

- (instancetype)init
{
  self = [super init];
  if (self) {
    _currentModuleIndex    = -1;
    _allowsSwitchModule    = YES;
    _moduleViewControllers = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  DCViewController *controller = [self controllerAtIndex:kDefaultModuleIndex];
  
  [self addChildViewController:self.menuViewController];
  [self addChildViewController:controller];
  
  self.currentModuleIndex = kDefaultModuleIndex;
}

- (instancetype)controllerAtIndex:(NSInteger)index
{
  NSInteger limit = sizeof(g_modules) / sizeof(g_modules[0]);
  if (index >= 0 && index < limit) {
    NSString *name = @(g_modules[index].viewControllerName);
    id controller = self.moduleViewControllers[name];
    
    if (!controller) {
      Class class = NSClassFromString(name);
      controller = [[class alloc] init];
      self.moduleViewControllers[name] = controller;
    }
    
    return controller;
  }
  
  return nil;
}

- (void)rotateMenuSettingsButtonClockwise:(BOOL)clockwise
{
  [self.menuViewController rotateSettingsButtonClockwise:clockwise];
}

#pragma mark -
#pragma mark MenuViewController Delegate

- (void)menuViewControllerDidSelectMenuAtIndex:(NSInteger)index
{
  if (index == self.currentModuleIndex) {
    return;
  }
  
  [self swtichModuleToIndex:index];
}

- (void)menuViewControllerDidSelectSettings
{
  [self.delegate baseViewControllerDidSelectSettingsMenuItem];
}

#pragma mark -
#pragma mark Switch Module

- (void)swtichModuleToIndex:(NSInteger)index
{
  [self.menuViewController lock];
  
  DCViewController *currentController = [self controllerAtIndex:self.currentModuleIndex];
  DCViewController *commingController = [self controllerAtIndex:index];
  
  [self setupControllerAtIndex:index];
  
  UIView *currentView = currentController.view;
  UIView *commingView = commingController.view;
  
  CGFloat h = CGRectGetHeight(currentView.bounds);
  CGFloat terminalY = index > self.currentModuleIndex ? h : -h;
  
  CGRect frame = commingView.frame;
  frame.origin.y = terminalY;
  commingView.frame = frame;
  
  CGRect leavingFrame = currentView.frame;
  leavingFrame.origin.y = -terminalY;
  
  [UIView animateWithDuration:0.4 animations:^{
    commingView.frame = currentView.frame;
    currentView.frame = leavingFrame;
  } completion:^(BOOL finished) {
    self.currentModuleIndex = index;
    [currentController removeFromParentViewController];
    
    [self.menuViewController unlock];
  }];
}

- (void)setupControllerAtIndex:(NSInteger)index
{
  id controller = [self controllerAtIndex:index];
  [self addChildViewController:controller];
}

#pragma mark -
#pragma mark View Layout

- (CGRect)viewFrameForChildViewController:(DCViewController *)child
{
  if (child == self.menuViewController) {
    return CGRectMake(0, 0, 60, 768);
  }
  else {
    return CGRectMake(60, 0, 964, 768);
  }
  
  return CGRectZero;
}

#pragma mark -
#pragma mark Did pop/dismiss back

- (void)didPopBack
{
  for (DCViewController *child in self.childViewControllers) {
    [child didPopBack];
  }
}

- (void)didDismissBack
{
  for (DCViewController *child in self.childViewControllers) {
    [child didDismissBack];
  }
}

#pragma mark -
#pragma mark Properties

- (MenuViewController *)menuViewController
{
  MenuViewController *controller = [MenuViewController getInstance];
  if (!controller.delegate) {
    controller.delegate = self;
  }
  return controller;
}

- (DCViewController *)currentModuleViewController
{
  return [self controllerAtIndex:self.currentModuleIndex];
}

- (void)setAllowsSwitchModule:(BOOL)allowsSwitchModule
{
  _allowsSwitchModule = allowsSwitchModule;
  self.menuViewController.normalMenuItemsEnabled = _allowsSwitchModule;
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
