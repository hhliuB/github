
/******************************************************************************
 *  @file   : OrgAPI.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-26
 *  @brief  : 架构数据接口
 ******************************************************************************/

#import "API.h"

#import "OrgEntities.h"

@interface OrgAPI : API

- (void)reloadOrgData:(void (^)(void))completion;

- (void)reloadOrgDataByEmployee:(Employee *)employee
                     completion:(void (^)(void))completion;

@end
