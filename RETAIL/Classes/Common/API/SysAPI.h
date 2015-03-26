
/******************************************************************************
 *  @file   : SysAPI.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-21
 *  @brief  : 系统数据接口
 ******************************************************************************/


#import "API.h"

#import "SysEntities.h"

@interface SysAPI : API

- (void)loadConfigs;

- (Config *)configForKey:(NSString *)key;

- (BOOL)hasInitialized;
- (void)setInitialized:(BOOL)initialized;

- (BOOL)is3GOn;
- (void)set3GOn:(BOOL)on;

- (void)clearCache;
- (void)resetDevice;

@end
