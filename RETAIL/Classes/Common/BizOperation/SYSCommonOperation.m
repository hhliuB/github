
/******************************************************************************
 *  @file   : SYSCommonOperation.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-20
 *  @brief  : 系统数据通用操作
 ******************************************************************************/

#import "SYSCommonOperation.h"

#import "DCDatabase.h"

@implementation SYSCommonOperation

#pragma mark -
#pragma mark LatestUpdateTime

- (void)saveLatestUpdateTime:(long long)time
                      withId:(NSString *)Id
                        type:(LatestUpdateTimeType)type
{
  LatestUpdateTime *ut = [[LatestUpdateTime alloc] init];
  ut.Id   = Id;
  ut.type = type;
  ut.time = time;
  [self.database updateObjects:@[ut]];
}

- (long long)latestUpdateTimeWithId:(NSString *)Id type:(LatestUpdateTimeType)type
{
  if (Id.length == 0) {
    return 0;
  }
  
  NSString *sql = [NSString stringWithFormat:
                   @"SELECT time FROM %@ WHERE Id = ? AND type = ?",
                   [LatestUpdateTime tableName]];
  NSArray *args = @[Id, @(type)];
  
  NSArray *result = [self.database query:sql withArguments:args];
  
  if (result.count > 0) {
    return [[result[0] allValues][0] longLongValue];    
  }
  
  return 0;
}

#pragma mark -
#pragma mark Config

- (void)saveConfigs:(NSArray *)configs
{
  if (configs.count > 0) {
    [self.database updateObjectsInTransaction:configs];
  }
}

- (void)saveConfig:(Config *)config
{
  if (config) {
    [self.database updateObjects:@[config]];
  }
}

- (NSArray *)configs
{
  return [self.database queryObjectsForClass:[Config class]];
}

- (Config *)configForKey:(NSString *)key
{
  NSString *sql = [NSString stringWithFormat:
                   @"SELECT value FROM %@ WHERE key = ?",
                   [Config tableName]];
  
  NSArray *result = [self.database query:sql withArguments:@[key]];
  
  if (result.count > 0) {
    return [[Config alloc] initWithDictionary:result[0]];
  }
  return nil;
}

@end
