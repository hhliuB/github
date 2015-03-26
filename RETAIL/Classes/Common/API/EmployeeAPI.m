
/******************************************************************************
 *  @file   : EmployeeAPI.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-26
 *  @brief  : 员工数据接口
 ******************************************************************************/

#import "EmployeeAPI.h"

#import "ORGCommonBiz.h"

#import "OrgCache.h"

@interface EmployeeAPI ()

@property (nonatomic,strong) ORGCommonBiz * orgBiz;

@property (nonatomic,readonly) OrgCache * orgCache;

@end

@implementation EmployeeAPI

- (id)init
{
  self = [super init];
  if (self) {
    _storage = [[OrgStorage alloc] init];
  }
  return self;
}

- (void)reloadEmployees
{
  [self.orgBiz loadMe];
  
//  self.storage.me = self.orgCache.me;
}

- (void)reloadSubordinates
{
  [self.orgBiz loadSubordinates];
}

- (void)reloadManagers
{
  [self.orgBiz loadManagers];
}

- (Subordinate *)subordinateById:(NSString *)employeeId
{
  NSPredicate *pre = [NSPredicate predicateWithFormat:@"Id = %@", employeeId];
  Subordinate *sub = [[self.orgCache.subordinates filteredArrayUsingPredicate:pre] firstObject];
  
  return sub;
}

- (void)saveEmployee:(Employee *)employee
{
  if (!employee) {
    return;
  }
  [self.orgBiz saveEmployee:employee];
}

#pragma mark -
#pragma mark Properties

- (ORGCommonBiz *)orgBiz
{
  if (!_orgBiz) {
    _orgBiz = [[ORGCommonBiz alloc] init];
  }
  return _orgBiz;
}

- (OrgCache *)orgCache
{
  return [OrgCache getInstance];
}

@end
