
/******************************************************************************
 *  @file   : SYSCommonOperation.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-20
 *  @brief  : 系统数据通用操作
 ******************************************************************************/

#import "BizDatabaseOperation.h"

#import "SysEntities.h"

@interface SYSCommonOperation : BizDatabaseOperation

#pragma mark -
#pragma mark LatestUpdateTime

- (void)saveLatestUpdateTime:(long long)time
                      withId:(NSString *)Id
                        type:(LatestUpdateTimeType)type;

- (long long)latestUpdateTimeWithId:(NSString *)Id type:(LatestUpdateTimeType)type;

#pragma mark -
#pragma mark Config

- (void)saveConfigs:(NSArray *)configs;
- (void)saveConfig:(Config *)config;

- (NSArray *)configs;
- (Config *)configForKey:(NSString *)key;

@end
