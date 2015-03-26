
/******************************************************************************
 *  @file   : ORGCommonOperation.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-20
 *  @brief  : 架构数据通用操作
 ******************************************************************************/

#import "ORGCommonOperation.h"

#import "DCDatabase.h"

@implementation ORGCommonOperation

- (NSArray *)employees
{
  return [self.database queryObjectsForClass:[Employee class]];
}

- (NSArray *)subordiantes
{
  return [self.database queryObjectsForClass:[Subordinate class]
                                   condition:@{@"isActive" : @YES}
                                     orderBy:@"pinyin"
                                        desc:NO];
}

- (NSArray *)managers
{
  return [self.database queryObjectsForClass:[Manager class]
                                   condition:@{@"isActive" : @YES}
                                     orderBy:@"pinyin"
                                        desc:NO];
}

- (NSArray *)postsOfEmployeed:(Employee *)employee
{
  if (!employee || employee.Id.length == 0) {
    return nil;
  }
  
  NSString *post         = [Post          tableName];
  NSString *postEmployee = [Post_Employee tableName];
  
  NSString *sql = [NSString stringWithFormat:
                   @"SELECT     *                 \
                     FROM       %@                \
                     INNER JOIN %@                \
                     ON         %@.Id = %@.postId \
                     WHERE      %@.employeeId = ? \
                       AND      %@.isActive   = ? \
                       AND      %@.isActive   = ?",
                   post,
                   postEmployee,
                   post, postEmployee,
                   postEmployee, post, postEmployee];
  
  NSArray *result = [self.database query:sql
                           withArguments:@[employee.Id, @YES, @YES]
                               convertTo:[Post class]];
  return result;
}

- (void)clearSubordinateOrgWithSubordinateId:(NSString *)subordinateId
{
  NSArray *args = @[subordinateId];
  
  NSString *sqlRDHP = [NSString stringWithFormat:
                       @"DELETE FROM %@ WHERE employeeId = ?",
                       [Post_Employee tableName]];
  
  [self.database update:sqlRDHP withArguments:args];
  
  NSString *sqlPost = [NSString stringWithFormat:
                       @"DELETE FROM %@ WHERE Id NOT IN \
                         (                              \
                           SELECT postId FROM %@        \
                         )",
                       [Post tableName],
                       [Post_Employee tableName]];
  
  [self.database update:sqlPost];
}

- (void)saveEmploye:(Employee *)employee
{
  if (!employee) {
    return;
  }
  
  NSString *transactionId = [NSString stringWithFormat:@"%s", __FUNCTION__];
  [self.database beginTransaction:transactionId];
  
  [self.database clearTableForClass:[Employee class]];
  [self.database updateObjects:@[employee]];
  
  [self.database commit:transactionId];
}

@end
