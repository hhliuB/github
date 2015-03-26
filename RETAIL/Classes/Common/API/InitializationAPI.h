
/******************************************************************************
 *  @file   : InitializationAPI.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-26
 *  @brief  : 初始化数据接口
 ******************************************************************************/

#import "API.h"

@interface InitializationAPI : API

- (void)initializeIfNecessary:(void (^)(int stepIndex, int totalSteps, NSString *progress))progress
                   completion:(void (^)(BOOL success, NSString *errMsg))completion;

@end
