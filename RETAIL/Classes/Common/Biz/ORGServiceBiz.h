
/******************************************************************************
 *  @file   : ORGServiceBiz.h
 *  @author : WANG JIE
 *  @date   : 2014-12-12
 *  @brief  : 架构数据服务器接口业务
 ******************************************************************************/

#import "Biz.h"

#import "OrgEntities.h"

@interface ORGServiceBiz : Biz

- (void)reloadOrgDataByEmployee:(Employee *)employee
                     completion:(void (^)(void))completion;

@end
