
/******************************************************************************
 *  @file   : ORGCommonBiz.h
 *  @author : WANG JIE
 *  @date   : 2014-12-11
 *  @brief  : 架构数据通用业务
 ******************************************************************************/

#import "Biz.h"

#import "OrgEntities.h"

@interface ORGCommonBiz : Biz

- (void)loadMe;
- (void)loadSubordinates;
- (void)loadManagers;

- (void)saveEmployee:(Employee *)employee;

@end
