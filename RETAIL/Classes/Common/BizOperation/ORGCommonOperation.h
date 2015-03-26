
/******************************************************************************
 *  @file   : ORGCommonOperation.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-20
 *  @brief  : 架构数据通用操作
 ******************************************************************************/

#import "BizDatabaseOperation.h"

#import "OrgEntities.h"

@interface ORGCommonOperation : BizDatabaseOperation

- (NSArray *)employees;
- (NSArray *)subordiantes;
- (NSArray *)managers;

- (NSArray *)postsOfEmployeed:(Employee *)employee;

- (void)saveEmploye:(Employee *)employee;

- (void)clearSubordinateOrgWithSubordinateId:(NSString *)subordinateId;

@end
