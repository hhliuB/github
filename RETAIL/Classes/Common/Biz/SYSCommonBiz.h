
/******************************************************************************
 *  @file   : SYSCommonBiz.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-21
 *  @brief  : 系统数据通用业务
 ******************************************************************************/

#import "Biz.h"

@class Config;

@interface SYSCommonBiz : Biz

#pragma mark -
#pragma mark Configs

- (void)getConfigs:(void (^)(void))completion;

- (void)loadConfigs;
- (Config *)configForKey:(NSString *)key;

- (void)saveConfigs;
- (void)saveConfigs:(NSArray *)configs;
- (void)saveConfigValue:(NSString *)value forKey:(NSString *)key;

#pragma mark - 
#pragma mark UserDefaults

- (BOOL)hasInitialized;
- (void)setInitialized:(BOOL)initialized;

- (BOOL)is3GOn;
- (void)set3GOn:(BOOL)on;

- (void)resetUserDefaults;

- (BOOL)userDefaultsBoolForKey:(NSString *)key;
- (id)userDefaultsObjectForKey:(NSString *)key;
- (void)setUserDefaultBool:(BOOL)value forKey:(NSString *)key;
- (void)setUserDefaultObject:(id)object forKey:(NSString *)key;

#pragma mark -
#pragma mark Other

- (void)clearDatabase;
- (BOOL)isDatabasePath:(NSString *)path;

@end
