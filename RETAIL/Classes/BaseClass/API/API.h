
/******************************************************************************
 *  @file   : API.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-13
 *  @brief  : 业务接口基类（抽象类）
 ******************************************************************************/

#import <Foundation/Foundation.h>

@interface API : NSObject

@property (nonatomic,readonly) NSOperationQueue *operationQueue;

+ (instancetype)api;

@end

NS_INLINE void EXECUTE_OPERATION(API *api, dispatch_block_t block)
{
  [api.operationQueue addOperationWithBlock:block];
}

NS_INLINE void EXECUTE_COMPLETION(dispatch_block_t block)
{
  dispatch_async(dispatch_get_main_queue(), block);
}
