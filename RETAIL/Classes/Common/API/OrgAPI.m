
/******************************************************************************
 *  @file   : OrgAPI.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-26
 *  @brief  : 架构数据接口
 ******************************************************************************/

#import "OrgAPI.h"

#import "ORGCommonBiz.h"
#import "ORGServiceBiz.h"

#import "OrgCache.h"

@interface OrgAPI ()

@property (nonatomic,strong) ORGCommonBiz  * commonBiz;
@property (nonatomic,strong) ORGServiceBiz * serviceBiz;

@property (nonatomic,readonly) OrgCache * orgCache;

@end

@implementation OrgAPI

- (void)reloadOrgData:(void (^)(void))completion
{
  [self reloadOrgDataByEmployee:self.orgCache.me completion:completion];
}

- (void)reloadOrgDataByEmployee:(Employee *)employee
                     completion:(void (^)(void))completion
{
  [self.serviceBiz reloadOrgDataByEmployee:employee completion:^{
    completion();
  }];
}

#pragma mark -

- (ORGCommonBiz *)commonBiz
{
  if (!_commonBiz) {
    _commonBiz = [ORGCommonBiz biz];
  }
  return _commonBiz;
}

- (ORGServiceBiz *)serviceBiz
{
  if (!_serviceBiz) {
    _serviceBiz = [ORGServiceBiz biz];
  }
  return _serviceBiz;
}

- (OrgCache *)orgCache
{
  return [OrgCache getInstance];
}

@end
