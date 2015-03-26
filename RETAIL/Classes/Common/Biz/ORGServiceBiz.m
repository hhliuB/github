
/******************************************************************************
 *  @file   : ORGServiceBiz.m
 *  @author : WANG JIE
 *  @date   : 2014-12-12
 *  @brief  : 架构数据服务器接口业务
 ******************************************************************************/

#import "ORGServiceBiz.h"

#import "DCResult.h"

#import "SYSCommonOperation.h"
#import "ORGCommonOperation.h"
#import "ORGServiceOperation.h"

#import "OrgCache.h"
#import "OrgServiceCache.h"

@interface ORGServiceBiz ()

@property (nonatomic,strong) SYSCommonOperation  * sysOperation;
@property (nonatomic,strong) ORGCommonOperation  * orgOperation;
@property (nonatomic,strong) ORGServiceOperation * orgServiceOperation;

@property (nonatomic,readonly) OrgCache        * orgCache;
@property (nonatomic,readonly) OrgServiceCache * orgServiceCache;

@end

@implementation ORGServiceBiz

- (void)reloadOrgDataByEmployee:(Employee *)employee
                     completion:(void (^)(void))completion
{
  long long time = [self.sysOperation latestUpdateTimeWithId:employee.Id
                                                        type:LatestUpdateTimeTypeOrg];
  
  [self.orgServiceOperation getOrgWithEmployeeId:employee.Id
                                      updateTime:time
                                      completion:
   ^{
     if (self.orgServiceCache.result.success) {
       [self handleOrgServiceResult];
     }
     
     [self reloadDataOfORGCache];
     
     DCResult *result = self.orgServiceCache.result;
     [self.orgServiceCache clear];
     self.orgServiceCache.result = result;
     
     completion();
   }];
}

- (void)reloadDataOfORGCache
{
  self.orgCache.me           = [[self.orgOperation employees] firstObject];
  self.orgCache.subordinates = [self.orgOperation subordiantes];
  self.orgCache.managers     = [self.orgOperation managers];
}

#pragma mark -
#pragma mark Private

- (void)handleOrgServiceResult
{
  NSString *transactionId = [NSString stringWithFormat:@"%s", __FUNCTION__];
  [self.orgDatabase beginTransaction:transactionId];
  
  [self.sysOperation saveLatestUpdateTime:self.orgServiceCache.serverTime
                                   withId:self.orgServiceCache.employeeId
                                     type:LatestUpdateTimeTypeOrg];
  
  BOOL isMe = [self.orgServiceCache.user.Id isEqualToString:self.orgCache.me.Id];
  
  if (isMe) {
    if (self.orgServiceCache.needReset) {
      [self clearOrg];
    }
    else {
      [self clearWholeUpdatedOrg];
    }
  }
  else {
    if (self.orgServiceCache.needReset) {
      [self.orgOperation clearSubordinateOrgWithSubordinateId:self.orgServiceCache.user.Id];
    }
  }
  
  if (isMe) {
    [self.orgOperation saveEmploye:self.orgServiceCache.user];
    
    [self.orgDatabase updateObjects:self.orgServiceCache.managers];
    [self.orgDatabase updateObjects:self.orgServiceCache.subordinates];
  }
  
  [self.orgDatabase updateObjects:self.orgServiceCache.posts];
  [self.orgDatabase updateObjects:self.orgServiceCache.postEmployees];
  [self.orgDatabase updateObjects:self.orgServiceCache.departments];
  
  [self.orgDatabase updateObjects:self.orgServiceCache.products];
  [self.orgDatabase updateObjects:self.orgServiceCache.doctors];
  [self.orgDatabase updateObjects:self.orgServiceCache.hospitals];
  
  [self.orgDatabase updateObjects:self.orgServiceCache.hospDepartments];
  [self.orgDatabase updateObjects:self.orgServiceCache.hospDepartmentDoctors];
  [self.orgDatabase updateObjects:self.orgServiceCache.doctorProducts];
  
  [self.orgDatabase updateObjects:self.orgServiceCache.postSalesUnits];
  [self.orgDatabase updateObjects:self.orgServiceCache.sysCodes];
  [self.orgDatabase updateObjects:self.orgServiceCache.contectInfos];
  
  [self.orgDatabase commit:transactionId];
}

- (void)clearOrg
{
  Class classes[] = {
    [Manager class],
    [Subordinate class],
    
    [Post class],
    [Post_Employee class],
    
    [Department class],
    [Product class],
    [Doctor class],
    [Hospital class],
    [HospDepartment class],
    [HospDepartment_Doctor class],
    [DoctorProduct class],
    [Post_Sales_Unit class],
    [SysCode class]
  };
  
  for (int i = 0; i < sizeof(classes) / sizeof(classes[0]); i++) {
    [self.orgDatabase clearTableForClass:classes[i]];
  }
}

- (void)clearWholeUpdatedOrg
{
  Class classes[] = {
    [Manager class],
    [Subordinate class],
    
    [Post class],
    [Post_Employee class]
  };
  
  for (int i = 0; i < sizeof(classes) / sizeof(classes[0]); i++) {
    [self.orgDatabase clearTableForClass:classes[i]];
  }
}

#pragma mark -
#pragma mark -

- (SYSCommonOperation *)sysOperation
{
  if (!_sysOperation) {
    _sysOperation = [SYSCommonOperation operationWithDatabase:self.sysDatabase];
  }
  return _sysOperation;
}

- (ORGCommonOperation *)orgOperation
{
  if (!_orgOperation) {
    _orgOperation = [ORGCommonOperation operationWithDatabase:self.orgDatabase];
  }
  return _orgOperation;
}

- (ORGServiceOperation *)orgServiceOperation
{
  if (!_orgServiceOperation) {
    _orgServiceOperation = [ORGServiceOperation operation];
  }
  return _orgServiceOperation;
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
