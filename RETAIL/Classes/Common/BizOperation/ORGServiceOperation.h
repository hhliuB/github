
/******************************************************************************
 *  @file   : ORGServiceOperation.h
 *  @author : WANG JIE
 *  @date   : 2014-12-12
 *  @brief  : 架构数据服务器接口操作
 ******************************************************************************/

#import "BizNetworkOperation.h"

@interface ORGServiceOperation : BizNetworkOperation

- (void)getOrgWithEmployeeId:(NSString *)employeeId
                  updateTime:(long long)updateTime
                  completion:(void (^)(void))completion;

@end
