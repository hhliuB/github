
/******************************************************************************
 *  @file   : AppDelegate.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-10
 *  @brief  : 应用程序代理
 *            负责进入应用程序时，根据不同状态，使程序跳转至登录或直接进入
 ******************************************************************************/

#import "AppDelegate.h"
#import "iConsole.h"

#import "RootViewController.h"

#import "OAuth2ViewController.h"

typedef NS_ENUM(NSInteger, ActionTypeWhenAppBecomeActive) {
  ActionTypeNone,
  ActionTypeLogin,
  ActionTypeEnter,
  ActionTypeReloadEssentialData,
};

@interface AppDelegate ()

@property (nonatomic,readonly) RootViewController *rootViewController;

@property (nonatomic,assign) ActionTypeWhenAppBecomeActive actionType;
@property (nonatomic,assign) BOOL                          isEntered;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSLog(@"%@", AppGroupDirectory());
  
#if kIConsoleEnabled
  self.window = [[iConsoleWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
#else
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
#endif
  
  self.window.backgroundColor    = [UIColor whiteColor];
  
  NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString *filePath = [doc stringByAppendingPathComponent:@"account.plist"];
  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
  if (dic == nil) {
    self.window.rootViewController = [[OAuth2ViewController alloc]init];
  }
  else {
    self.window.rootViewController = self.rootViewController;
  }
  
  [self.window makeKeyAndVisible];
  
  self.actionType = ActionTypeLogin;
  
  [self registerApplicationNotifications];
  
#if kLoginEnabled
  [self login];
#else
  [self enter];
#endif
  
  return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
  if ([sourceApplication isEqualToString:@"com.ideabinder.SFA-ESSENTIALS-LOGIN"]) {
    self.actionType = self.isEntered ? ActionTypeReloadEssentialData : ActionTypeEnter;
    return YES;
  }
  
  return NO;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  [self removeApplicationNotifications];
}

#pragma mark -
#pragma mark Private Methods

- (void)login
{
  NSMutableString *urlString = [NSMutableString stringWithString:@"idb-sfa-login://"];
  [urlString appendString:@"sourceScheme=idb-sfa-template"];
  
  NSURL *loginUrl = [NSURL URLWithString:urlString];
  [[UIApplication sharedApplication] openURL:loginUrl];
}

- (void)enter
{
  [self.rootViewController enter];
  self.isEntered  = YES;
  self.actionType = ActionTypeNone;
}

- (void)reloadEssentialData
{
  [self.rootViewController reloadEssentialData];
  self.actionType = ActionTypeNone;
}

#pragma mark -
#pragma mark Notifications

- (void)registerApplicationNotifications
{
  NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
  [notiCenter addObserverForName:UIApplicationDidBecomeActiveNotification
                          object:nil
                           queue:nil
                      usingBlock:^(NSNotification *note) {
                        switch (self.actionType) {
                          case ActionTypeLogin:
                            [self login];
                            break;
                          case ActionTypeEnter:
                            [self enter];
                            self.isEntered = YES;
                            break;
                          case ActionTypeReloadEssentialData:
                            [self reloadEssentialData];
                            break;
                          default:
                            break;
                        }
                      }];
  
  [notiCenter addObserverForName:UIApplicationDidEnterBackgroundNotification
                          object:nil
                           queue:nil
                      usingBlock:^(NSNotification *note) {
                        self.actionType = ActionTypeLogin;
                      }];
}

- (void)removeApplicationNotifications
{
  NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
  [notiCenter removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
  [notiCenter removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

#pragma mark -
#pragma mark Properties

- (RootViewController *)rootViewController
{
  return [RootViewController getInstance];
}

@end
