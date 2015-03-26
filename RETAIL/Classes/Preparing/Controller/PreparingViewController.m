
/******************************************************************************
 *  @file   : PreparingViewController.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-10-31
 *  @brief  : 用于准备进入 App 时必要的数据，并执行相应的 UI 动画
 ******************************************************************************/

#import "PreparingViewController.h"
#import "PreparingView.h"

@interface PreparingViewController ()

@property (nonatomic,strong) PreparingView *view;

@end

@implementation PreparingViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view = [[PreparingView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
  self.view.backgroundColor = kMainColor;
  self.view.logo = self.logo;
}

- (void)attachImage:(UIImage *)image on:(CGPoint)topLeft
{
  UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
  
  CGRect frame = imageView.bounds;
  frame.origin = topLeft;
  imageView.frame = frame;
  
  [self.view addSubview:imageView];
}

- (void)setProgress:(float)progress
{
  [self.view setProgress:progress animated:YES];
}

- (void)setMessage:(NSString *)message
{
  [self.view setMessage:message];
}

- (void)setLogo:(UIImage *)logo
{
  _logo = logo;
  self.view.logo = logo;
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
