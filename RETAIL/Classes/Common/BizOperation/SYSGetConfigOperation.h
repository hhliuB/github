
/******************************************************************************
 *  @file   : SYSGetConfigOperation.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-29
 *  @brief  : 获取系统配置信息操作
 ******************************************************************************/

#import "BizNetworkOperation.h"

@interface SYSGetConfigOperation : BizNetworkOperation

- (void)getConfigs:(void (^)(void))completion;

@end
