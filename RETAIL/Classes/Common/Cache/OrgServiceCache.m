
/******************************************************************************
 *  @file   : OrgServiceCache.m
 *  @author : WANG JIE
 *  @date   : 2014-12-18
 *  @brief  : 架构接口数据缓存
 ******************************************************************************/

#import "OrgServiceCache.h"

@implementation OrgServiceCache

- (void)clear
{
  self.employeeId = @"";
  
  self.needReset = NO;
  self.serverTime = 0;
  
  self.user = nil;
  self.subordinates = nil;
  self.managers = nil;
  
  self.posts = self.postEmployees = self.departments = nil;
  self.products = self.hospitals = self.doctors = nil;
  self.hospDepartments = self.hospDepartmentDoctors = self.doctorProducts = nil;
  self.postSalesUnits = self.sysCodes = self.contectInfos = nil;
}

#pragma mark -
#pragma mark Singleton Definition

static id instance = nil;

+ (instancetype)getInstance
{
  @synchronized(self){
    if (!instance) {
      instance = [[self alloc] init];
    }
  }
  
  return instance;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
  @synchronized(self){
    if (!instance) {
      instance = [super allocWithZone:zone];
    }
  }
  
  return instance;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
  return self;
}

@end
