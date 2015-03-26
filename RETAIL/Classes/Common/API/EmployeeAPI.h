
/******************************************************************************
 *  @file   : EmployeeAPI.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-26
 *  @brief  : 员工数据接口
 ******************************************************************************/

#import "API.h"

#import "OrgStorage.h"

@interface EmployeeAPI : API

@property (nonatomic,readonly) OrgStorage * storage;

- (void)reloadEmployees;

- (void)reloadSubordinates;
- (void)reloadManagers;

- (Subordinate *)subordinateById:(NSString *)employeeId;

- (void)saveEmployee:(Employee *)employee;

@end
