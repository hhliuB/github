
/******************************************************************************
 *  @file   : SettingsViewController.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-15
 *  @brief  : 【设置】视图控制器
 ******************************************************************************/

#import "SettingsViewController.h"

#import "SettingsView.h"
#import "SettingsProtocol.h"

@interface SettingsViewController ()

@property (nonatomic,readonly) SettingsView    *view;
@property (nonatomic,strong)   SettingsProtocol *protocol;

@end

@implementation SettingsViewController

@synthesize protocol = _protocol;

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = kWhiteColor;
  
  self.protocol.controller = self;
  self.view.tableView.dataSource = self.protocol;
  self.view.tableView.delegate   = self.protocol;

  [self.view.tableView reloadData];
}

#pragma mark -
#pragma mark View Layout

- (Class)viewClass
{
  return [SettingsView class];
}

#pragma mark -
#pragma mark Properties

- (SettingsProtocol *)protocol
{
  return GetInstance([SettingsProtocol class], _protocol);
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
