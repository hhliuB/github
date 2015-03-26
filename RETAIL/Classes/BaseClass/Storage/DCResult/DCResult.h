
/******************************************************************************
 *  @file   : DCResult.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-21
 *  @brief  : 业务操作结果基类
 ******************************************************************************/

#import <Foundation/Foundation.h>

@interface DCResult : NSObject

@property (nonatomic,readonly) BOOL          success;
@property (nonatomic,readonly) NSInteger     errorCode;
@property (nonatomic,readonly) NSString     *errorMessage;
@property (nonatomic,readonly) NSDictionary *userInfo;

+ (instancetype)successResult;

+ (instancetype)errorResultWithCode:(NSInteger)code
                            message:(NSString *)message;

+ (instancetype)errorResultWithCode:(NSInteger)code
                            message:(NSString *)message
                           userInfo:(NSDictionary *)userInfo;

@end
