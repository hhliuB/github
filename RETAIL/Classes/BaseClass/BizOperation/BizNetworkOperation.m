/******************************************************************************
 *  @file   : BizNetworkOperation.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-20
 *  @brief  : 网络请求业务操作基类（抽象类）
 ******************************************************************************/

#import "BizNetworkOperation.h"

#import "DCHttpRequest.h"

@implementation BizNetworkOperation

+ (instancetype)operation
{
  return [[self alloc] init];
}

@end

@implementation BizNetworkOperation (DCHttpRequestConvenience)

- (DCHttpRequest *)getRequestWithBaseUrl:(NSString *)baseUrl method:(NSString *)method params:(NSDictionary *)params
{
  return [self requestWithType:DCHttpRequestTypeGET baseUrl:baseUrl method:method params:params];
}

- (DCHttpRequest *)postRequestWithBaseUrl:(NSString *)baseUrl method:(NSString *)method params:(id)params
{
  return [self requestWithType:DCHttpRequestTypePOST baseUrl:baseUrl method:method params:params];
}

- (DCHttpRequest *)requestWithType:(DCHttpRequestType)type
                           baseUrl:(NSString *)baseUrl
                            method:(NSString *)method
                            params:(id)params
{
  DCHttpRequest *request = [[DCHttpRequest alloc] init];
  request.type    = type;
  request.baseUrl = baseUrl;
  request.method  = method;
  request.params  = params;
  
  request.allowsLogMethod       = YES;
  request.allowsLogHeader       = NO;
  request.allowsLogResponseGET  = YES;
  request.allowsLogResponsePOST = YES;
  request.allowsLogResponseHEAD = NO;
  request.allowsLogRequestError = YES;
  
  return request;
}

@end
