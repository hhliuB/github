
/******************************************************************************
 *  @file   : SYSCommonBiz.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-21
 *  @brief  : 系统数据通用业务
 ******************************************************************************/

#import "SYSCommonBiz.h"

#import "SYSCommonOperation.h"
#import "SYSGetConfigOperation.h"

#import "SysCache.h"

@interface SYSCommonBiz ()

@property (nonatomic,strong) SYSCommonOperation    * operation;
@property (nonatomic,strong) SYSGetConfigOperation * configOperation;

@property (nonatomic,readonly) SysCache * cache;

@end

@implementation SYSCommonBiz

#pragma mark -
#pragma mark Configs

- (void)getConfigs:(void (^)(void))completion
{
  [self.configOperation getConfigs:^{
    
    [self saveConfigs];
    
    completion();
  }];
}

- (void)loadConfigs
{
  self.cache.configs = [self.operation configs];
}

- (Config *)configForKey:(NSString *)key
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Key = %@", key];
  return [[self.cache.configs filteredArrayUsingPredicate:predicate] firstObject];
}

- (void)saveConfigs
{
  [self.operation saveConfigs:self.cache.configs];
}

- (void)saveConfigs:(NSArray *)configs
{
  [self.operation saveConfigs:configs];
  [self loadConfigs];
}

- (void)saveConfigValue:(NSString *)value forKey:(NSString *)key
{
  Config *config = [self configForKey:key];
  if (!config) {
    config = [[Config alloc] init];
  }
  config.value = value;
  
  [self.operation saveConfig:config];
  [self loadConfigs];
}

#pragma mark -
#pragma mark UserDefaults

- (BOOL)hasInitialized
{
  return [self userDefaultsBoolForKey:kUserDefaultsKeyHasInitialized];
}

- (void)setInitialized:(BOOL)initialized
{
  [self setUserDefaultBool:YES forKey:kUserDefaultsKeyHasInitialized];
}

- (BOOL)is3GOn
{
  return [self userDefaultsBoolForKey:kUserDefaultsKey3GOn];
}

- (void)set3GOn:(BOOL)on
{
  [self setUserDefaultBool:on forKey:kUserDefaultsKey3GOn];
}

- (void)resetUserDefaults
{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults removeObjectForKey:kUserDefaultsKeyLastUserName];
  [userDefaults synchronize];
  
  [self set3GOn:YES];
  [self setInitialized:NO];
}

- (BOOL)userDefaultsBoolForKey:(NSString *)key
{
  return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

- (id)userDefaultsObjectForKey:(NSString *)key
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)setUserDefaultBool:(BOOL)value forKey:(NSString *)key
{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setBool:value forKey:key];
  [userDefaults synchronize];
}

- (void)setUserDefaultObject:(id)object forKey:(NSString *)key
{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:object forKey:key];
  [userDefaults synchronize];
}

#pragma mark -
#pragma mark Other

// CUI ZHENSONG: 这个方法有待商榷。基于当前支持多App共享数据库的情境，【重置设备】功能应当怎样规划？
- (void)clearDatabase
{
  [self.sysDatabase cleanup];
  [self.loginDatabase cleanup];
  [self.orgDatabase cleanup];
  [self.libraryDatabase cleanup];
  [self.callDatabase cleanup];
}

- (BOOL)isDatabasePath:(NSString *)path
{
  __block BOOL isdbPath = NO;
  NSArray *dbs = @[self.sysDatabase, self.loginDatabase, self.orgDatabase, self.libraryDatabase, self.callDatabase];
  
  [dbs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    DCDatabase *db = obj;
    
    NSString *dbPath = db.path;
    if ([dbPath isEqualToString:path]) {
      isdbPath = YES;
      *stop = YES;
    }
  }];
  
  return isdbPath;
}

#pragma mark -
#pragma mark Properties

- (SYSCommonOperation *)operation
{
  if (!_operation) {
    _operation = [SYSCommonOperation operationWithDatabase:self.sysDatabase];
  }
  
  return _operation;
}

- (SYSGetConfigOperation *)configOperation
{
  if (!_configOperation) {
    _configOperation = [SYSGetConfigOperation operation];
  }
  return _configOperation;
}

- (SysCache *)cache
{
  return [SysCache getInstance];
}

@end
