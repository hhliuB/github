
/******************************************************************************
 *  @file   : SYSGetConfigOperation.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-29
 *  @brief  : 获取系统配置信息操作
 ******************************************************************************/

#import "SYSGetConfigOperation.h"

#import "DCResult.h"

#import "SysEntities.h"
#import "SysCache.h"

@interface SYSGetConfigOperation ()

@property (nonatomic,readonly) SysCache * cache;

@end

@implementation SYSGetConfigOperation

- (void)getConfigs:(void (^)(void))completion
{
  DCHttpRequest *request = [self getRequestWithBaseUrl:kDefaultHost
                                                method:@"GetConfig"
                                                params:@{@"AppId" : kAppId}];
  [request startWithSuccess:^(id result) {
    NSMutableArray *configs = [NSMutableArray arrayWithCapacity:[result count]];
    
    [result enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      Config *config = [[Config alloc] init];
      config.key   = key;
      config.value = obj;
      [configs addObject:config];
    }];
    
    DCResult *dcResult = [DCResult successResult];
    
    self.cache.configs = configs;
    self.cache.result = dcResult;
    
    completion();
    
  } failure:^(NSInteger errCode, NSString *errMsg, NSDictionary *userInfo) {
    DCResult *dcResult = [DCResult errorResultWithCode:errCode message:errMsg];
    
    self.cache.configs = nil;
    self.cache.result = dcResult;
    
    completion();
  }];
}

#pragma mark - 
#pragma mark Properties

- (SysCache *)cache
{
  return [SysCache getInstance];
}

@end
