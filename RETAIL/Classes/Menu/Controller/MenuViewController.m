
/******************************************************************************
 *  @file   : MenuViewController.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-11
 *  @brief  : 【菜单】视图控制器
 ******************************************************************************/

#import "MenuViewController.h"

#import "HRPMenuView.h"

#import "ModuleConstants.h"

@interface MenuViewController () <HRPMenuViewDelegate>

@property (nonatomic,readonly) HRPMenuView *view;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.delegate = self;
  self.view.backgroundColor = kDarkGrayColor;
  
  int cnt = sizeof(g_modules) / sizeof(g_modules[0]);
  NSMutableArray *menuItems = [NSMutableArray arrayWithCapacity:cnt];
  for (int i = 0; i < cnt; i++) {
    HRPMenuItem *menuItem = [self menuItemWithModuleStruct:g_modules[i]];
    [menuItems addObject:menuItem];
  }
  
  self.view.menuItems     = menuItems;
  self.view.selectedIndex = 0;
  
#if kSettingsModuleEnabled
  self.view.settingsItem  = [self settingsItem];
#endif
}

- (HRPMenuItem *)menuItemWithModuleStruct:(Module)module
{
  HRPMenuItem *item = [HRPMenuItem menuItemWithStyle:module.style];
  
  if (module.title) {
    item.title = @(module.title);
  }
  
  if (module.normalImageName) {
    item.normalImage = [UIImage imageNamed:@(module.normalImageName)];
  }
  
  if (module.selectedImageName) {
    item.selectedImage = [UIImage imageNamed:@(module.selectedImageName)];
  }
  
  item.selectedColor = kMainColor;
  
  return item;
}

- (HRPMenuSettingsItem *)settingsItem
{
  HRPMenuSettingsItem *item = [[HRPMenuSettingsItem alloc] init];
 
  if (g_settingsModule.normalImageName) {
    item.normalImage = [UIImage imageNamed:@(g_settingsModule.normalImageName)];
  }
  
  if (g_settingsModule.selectedImageName) {
    item.selectedImage = [UIImage imageNamed:@(g_settingsModule.selectedImageName)];
  }
  
  item.target = self;
  item.action = @selector(menuViewDidSelectSettingsItem);
  
  return item;
}

- (void)rotateSettingsButtonClockwise:(BOOL)clockwise
{
  [self.view rotateSettingsButtonClockwise:clockwise];
}

- (void)lock
{
  self.view.userInteractionEnabled = NO;
}

- (void)unlock
{
  self.view.userInteractionEnabled = YES;
}

#pragma mark -
#pragma mark HRPMenuView Delegate & Callback

- (void)menuViewDidSelectItemAtIndex:(NSInteger)index
{
  [self.delegate menuViewControllerDidSelectMenuAtIndex:index];
}

- (void)menuViewDidSelectSettingsItem
{
  [self.delegate menuViewControllerDidSelectSettings];
}

#pragma mark -
#pragma mark View Layout

- (Class)viewClass
{
  return [HRPMenuView class];
}

#pragma mark -
#pragma mark Properties

- (void)setNormalMenuItemsEnabled:(BOOL)normalMenuItemsEnabled
{
  self.view.normalMenuItemsEnabled = normalMenuItemsEnabled;
}

- (BOOL)normalMenuItemsEnabled
{
  return self.view.normalMenuItemsEnabled;
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
