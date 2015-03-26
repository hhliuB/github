
/******************************************************************************
 *  @file   : InitializationAPI.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-26
 *  @brief  : 初始化数据接口
 ******************************************************************************/

#import "InitializationAPI.h"

#import "SYSCommonBiz.h"
#import "ORGCommonBiz.h"
#import "ORGServiceBiz.h"

#import "OrgCache.h"
#import "OrgServiceCache.h"

#define kProgressReloadOrgData            @"正在获取架构数据"
#define kProgressReadeyForLogin           @"正在准备进入"

#define kErrorReloadOrgData               @"架构获取失败"

#define kProgressTotalSteps               2

@interface InitializationAPI ()

@property (nonatomic,strong) SYSCommonBiz  * sysBiz;
@property (nonatomic,strong) ORGCommonBiz  * orgBiz;
@property (nonatomic,strong) ORGServiceBiz * orgServiceBiz;

@property (nonatomic,readonly) OrgCache        * orgCache;
@property (nonatomic,readonly) OrgServiceCache * orgServiceCache;

@end

@implementation InitializationAPI

- (void)initializeIfNecessary:(void (^)(int, int, NSString *))progress
                   completion:(void (^)(BOOL, NSString *))completion
{
  BOOL hasInitialized = [self.sysBiz hasInitialized];
  
  int totalSteps = kProgressTotalSteps;
  
  __block int step = 0;
  
  if (!hasInitialized) {
    [self.sysBiz set3GOn:YES];

    //Step 1
    step++;
    progress(step, totalSteps, kProgressReloadOrgData);
    [self reloadOrgDataCompletion:^(BOOL success) {
      if (!success) {
        completion(NO, kErrorReloadOrgData);
        return ;
      }
      
      
      //Step 2
      step++;
      progress(step, totalSteps, kProgressReadeyForLogin);
      [self readyForLogin:^{
        completion(YES, @"");
      }];
      
    }];
  }
  else {
    
  }
}

#pragma mark -
#pragma mark Private Method

- (void)reloadOrgDataCompletion:(void(^)(BOOL success))completion
{
  [self.orgServiceBiz reloadOrgDataByEmployee:self.orgCache.me completion:^{
    BOOL success = self.orgServiceCache.result.success;
     completion(success);
   }];
}

- (void)readyForLogin:(void (^)(void))completion
{
  [self.sysBiz setInitialized:YES];
  
  completion();
}

#pragma mark -
#pragma mark Properties

- (SYSCommonBiz *)sysBiz
{
  if (!_sysBiz) {
    _sysBiz = [SYSCommonBiz biz];
  }
  return _sysBiz;
}

- (ORGCommonBiz *)orgBiz
{
  if (!_orgBiz) {
    _orgBiz = [ORGCommonBiz biz];
  }
  return _orgBiz;
}

- (ORGServiceBiz *)orgServiceBiz
{
  if (!_orgServiceBiz) {
    _orgServiceBiz = [ORGServiceBiz biz];
  }
  return _orgServiceBiz;
}

- (OrgCache *)orgCache
{
  return [OrgCache getInstance];
}

- (OrgServiceCache *)orgServiceCache
{
  return [OrgServiceCache getInstance];
}

@end
