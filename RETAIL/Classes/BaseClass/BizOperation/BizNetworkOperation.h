
/******************************************************************************
 *  @file   : BizNetworkOperation.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-20
 *  @brief  : 网络请求业务操作基类（抽象类）
 ******************************************************************************/


#import "BizOperation.h"

#import "DCHttpRequest.h"

@interface BizNetworkOperation : BizOperation

+ (instancetype)operation;

@end

@interface BizNetworkOperation (DCHttpRequestConvenience)

- (DCHttpRequest *)getRequestWithBaseUrl:(NSString *)baseUrl
                                  method:(NSString *)method
                                  params:(NSDictionary *)params;

- (DCHttpRequest *)postRequestWithBaseUrl:(NSString *)baseUrl
                                   method:(NSString *)method
                                   params:(id)params;

@end
