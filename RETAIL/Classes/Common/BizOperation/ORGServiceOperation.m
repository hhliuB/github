
/******************************************************************************
 *  @file   : ORGServiceOperation.m
 *  @author : WANG JIE
 *  @date   : 2014-12-12
 *  @brief  : 架构数据服务器接口操作
 ******************************************************************************/

#import "ORGServiceOperation.h"

#import "SysEntities.h"
#import "OrgEntities.h"

#import "OrgServiceCache.h"

@interface ORGServiceOperation ()

@property (nonatomic,readonly) OrgServiceCache * orgServiceCache;

@end

@implementation ORGServiceOperation

- (void)getOrgWithEmployeeId:(NSString *)employeeId
                  updateTime:(long long)updateTime
                  completion:(void (^)(void))completion
{
  [self.orgServiceCache clear];
  
  self.orgServiceCache.employeeId = employeeId;
  
  if (!employeeId) {
    completion();
    return;
  }
  
  NSDictionary *params = @{@"employeeId" : employeeId,
                           @"updatetime" : @(updateTime)
                           };
  
  DCHttpRequest *request = [self getRequestWithBaseUrl:kDefaultHost
                                                method:@"GetOrg"
                                                params:params];
  
  [request startWithSuccess:^(id result) {
    self.orgServiceCache.serverTime = [result[@"ServerTime"] longLongValue];
    self.orgServiceCache.needReset  = [result[@"NeedReset"] boolValue];
    
    self.orgServiceCache.user         = [[Employee alloc] initWithDictionary:result[@"User"]];
    
    self.orgServiceCache.subordinates = [self convertDictionaries:result[@"Subordinate"]
                                                          toClass:[Subordinate class]];
    self.orgServiceCache.managers     = [self convertDictionaries:result[@"Manager"]
                                                          toClass:[Manager class]];
    
    NSMutableDictionary *entitiesDict = [NSMutableDictionary dictionary];
    
    NSDictionary *keyClass = @{@"Post"                  : [Post class],
                               @"Post_Employee"         : [Post_Employee class],
                               
                               @"Department"            : [Department class],
                               @"Product"               : [Product class],
                               @"Doctor"                : [Doctor class],
                               @"Hospital"              : [Hospital class],
                               @"HospDepartment"        : [HospDepartment class],
                               @"HospDepartment_Doctor" : [HospDepartment_Doctor class],
                               @"Doctor_Product"        : [DoctorProduct class],
                               @"Post_Sales_Unit"       : [Post_Sales_Unit class],
                               @"System_Code"           : [SysCode class],
                               @"ContectInfo"           : [ContectInfo class],
                               };
    
    [keyClass enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      NSArray *objects = [self convertDictionaries:result[key]
                                           toClass:obj];
      if (objects) {
        [entitiesDict setObject:objects forKey:key];
      }
    }];
    
    self.orgServiceCache.posts           = entitiesDict[@"Post"];
    self.orgServiceCache.postEmployees   = entitiesDict[@"Post_Employee"];
    self.orgServiceCache.departments     = entitiesDict[@"Department"];
    
    self.orgServiceCache.products        = entitiesDict[@"Product"];
    self.orgServiceCache.doctors         = entitiesDict[@"Doctor"];
    self.orgServiceCache.hospitals       = entitiesDict[@"Hospital"];
    
    self.orgServiceCache.hospDepartments       = entitiesDict[@"HospDepartment"];
    self.orgServiceCache.hospDepartmentDoctors = entitiesDict[@"HospDepartment_Doctor"];
    self.orgServiceCache.doctorProducts        = entitiesDict[@"Doctor_Product"];
    
    self.orgServiceCache.postSalesUnits  = entitiesDict[@"Post_Sales_Unit"];
    self.orgServiceCache.sysCodes        = entitiesDict[@"System_Code"];
    self.orgServiceCache.contectInfos    = entitiesDict[@"ContectInfo"];
    
    self.orgServiceCache.result = [DCResult successResult];
    
    completion();
    
  } failure:^(NSInteger errCode, NSString *errMsg, NSDictionary *userInfo) {
    self.orgServiceCache.result = [DCResult errorResultWithCode:errCode
                                                        message:errMsg
                                                       userInfo:userInfo];
    
    completion();
    
  }];
}

#pragma mark -
#pragma mark Properties

- (OrgServiceCache *)orgServiceCache
{
  return [OrgServiceCache getInstance];
}

@end
