/******************************************************************************
 *  @file   : RootViewController.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-12
 *  @brief  : 负责布局 MainViewController 和 PreparingViewController，
 *            以及获取主数据
 ******************************************************************************/

#import "RootViewController.h"

#import "MainViewController.h"
#import "PreparingViewController.h"

#import "PreparingAPI.h"
#import "EmployeeAPI.h"

#import "Macro.h"

@interface RootViewController ()

@property (nonatomic,strong) MainViewController      *mainViewController;
@property (nonatomic,strong) PreparingViewController *preparingViewController;

@property (nonatomic,strong) PreparingAPI *preparingApi;
@property (nonatomic,strong) EmployeeAPI *employeeApi;

@end

@implementation RootViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = kDarkGrayColor;
}

- (void)enter
{
  [self getEssentialData:^(BOOL success) {
    if (success) {
      [self addChildViewController:self.mainViewController];
      
      [self.view bringSubviewToFront:self.preparingViewController.view];
      [self.preparingViewController.view fadeout:^{
        [self.preparingViewController removeFromParentViewController];
      }];
    }
  }];
}

- (void)reloadEssentialData
{
  [self getEssentialData:nil];
}

- (void)getEssentialData:(void (^)(BOOL success))completion
{
  [self addChildViewController:self.preparingViewController];
  
  [self.preparingApi getEssentialData:^(int stepIndex, int totalSteps, NSString *progress) {
    CGFloat   p       = (CGFloat)stepIndex / totalSteps;
    NSString *message = nil;
    if (progress.length > 0) {
      message = [NSString stringWithFormat: @"%@ (%d/%d)", progress, stepIndex, totalSteps];
    }
    else {
      message = [NSString stringWithFormat: @"%d/%d", stepIndex, totalSteps];
    }
    
    [self.preparingViewController setMessage:message];
    [self.preparingViewController setProgress:p];
    
  } completion:^(BOOL success, NSString *errMsg) {
    [self.employeeApi reloadEmployees];
    
    if (success) {
      [self.preparingViewController.view fadeout:^{
        [self.preparingViewController.view removeFromSuperview];
        self.preparingViewController = nil;
      }];
    }
    else {
      [self.preparingViewController setMessage:errMsg];
    }
    
    if (completion) {
      completion(success);
    }
  }];
}

#pragma mark -
#pragma mark View Layout

- (CGRect)viewFrameForChildViewController:(DCViewController *)child
{
  return CGRectMake(0, 0, 1024, 768);
}

#pragma mark -
#pragma mark Properties

- (MainViewController *)mainViewController
{
  return [MainViewController getInstance];
}

- (PreparingViewController *)preparingViewController
{
  return [PreparingViewController getInstance];
}

- (PreparingAPI *)preparingApi
{
  return GetInstance([PreparingAPI class], _preparingApi);
}

- (EmployeeAPI *)employeeApi
{
  return GetInstance([EmployeeAPI class], _employeeApi);
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
