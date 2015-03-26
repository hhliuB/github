
/******************************************************************************
 *  @file   : ORGCommonBiz.m
 *  @author : WANG JIE
 *  @date   : 2014-12-11
 *  @brief  : 架构数据通用业务
 ******************************************************************************/

#import "ORGCommonBiz.h"

#import "ORGCommonOperation.h"

#import "OrgCache.h"

@interface ORGCommonBiz ()

@property (nonatomic,strong)   ORGCommonOperation * operation;
@property (nonatomic,readonly) OrgCache           * cache;

@end

@implementation ORGCommonBiz

- (void)loadMe
{
//  self.cache.me = [[self.operation employees] firstObject];
}

- (void)loadSubordinates
{
  self.cache.subordinates = [self.operation subordiantes];
}

- (void)loadManagers
{
  self.cache.managers = [self.operation managers];
}

- (void)saveEmployee:(Employee *)employee
{
  [self.operation saveEmploye:employee];
}

#pragma mark - 
#pragma mark Properties

- (ORGCommonOperation *)operation
{
  if (!_operation) {
    _operation = [ORGCommonOperation operationWithDatabase:self.orgDatabase];
  }
  
  return _operation;
}

- (OrgCache *)cache
{
  return [OrgCache getInstance];
}
          
@end
