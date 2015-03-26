
/******************************************************************************
 *  @file   : PreparingAPI.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-03
 *  @brief  : 准备给进入 App 时，获取数据的接口
 ******************************************************************************/

#import <Foundation/Foundation.h>

@interface PreparingAPI : NSObject

- (void)getEssentialData:(void (^)(int stepIndex, int totalSteps, NSString *progress))progress
              completion:(void (^)(BOOL success, NSString *errMsg))completion;

@end
