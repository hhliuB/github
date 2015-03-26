//
//  DCHttpRequest.m
//  DCHttpRequest
//
//  Created by Duke on 14-7-24.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import "DCHttpRequest.h"
#import "DCReachability.h"

#import "AFNetworking.h"
#import "AFgzipRequestSerializer.h"

#import "NSString+HttpRequestAdditions.h"

#import "JSONKit.h"
#import "AES.h"

@interface DCHttpRequest ()

@property (nonatomic,strong) DCReachability         * reachability;
@property (nonatomic,strong) AFHTTPRequestOperation * operation;
@property (nonatomic,strong) NSMutableURLRequest    * request;

@property (nonatomic,readonly) NSString * typeString;
@property (nonatomic,readonly) id         completeParams;

@property (nonatomic,strong) NSMutableDictionary *additionalHeader;

@end

@implementation DCHttpRequest

- (instancetype)init
{
  self = [super init];

  if (self) {
    _type             = DCHttpRequestTypeGET;
    _timeout          = 15.0;
    _additionalHeader = [NSMutableDictionary dictionary];
  }
  
  return self;
}

+ (instancetype)request
{
  return [[self alloc] init];
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
  if (value == nil) {
    [self.additionalHeader removeObjectForKey:field];
  }
  else {
    self.additionalHeader[field] = value;
  }
}

- (void)startWithSuccess:(void (^)(id))success
                 failure:(void (^)(NSInteger, NSString *, NSDictionary *))failure
{
  if (!self.reachability.isReachable) {
    if (self.allowsLogRequestError) {
      NSLog(@"\nmethod:%@\nerrorCode:%d\n%@\n\n", self.method, 0, @"无法连接网络");
    }
    failure(0, @"无法连接网络", nil);
    return;
  }
  
  if (self.type == DCHttpRequestTypePOST) {
    [self preparePostRequest];
  }
  else {
    [self prepareGetRequest];
  }

  NSString          *method = self.method;
  DCHttpRequestType  type   = self.type;
  
  BOOL      isEncryptionEnabled = self.isEncryptionEnabled;
  NSString *encryptionKey       = self.encryptionKey;
  
  BOOL allowsLogResponseGET  = self.allowsLogResponseGET;
  BOOL allowsLogResponsePOST = self.allowsLogResponsePOST;
  BOOL allowsLogResponseHEAD = self.allowsLogResponseHEAD;
  BOOL allowsLogRequestError = self.allowsLogRequestError;
  
  if (isEncryptionEnabled) {
    self.operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
  }
  else {
    self.operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
  }
  
  [self.operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSInteger  statusCode     = operation.response.statusCode;
    NSString  *headerString   = [operation.response.allHeaderFields JSONString];
    NSString  *responseString = nil;
    
    if (isEncryptionEnabled) {
      NSString *encryptedString = [[NSString alloc] initWithData:responseObject
                                                        encoding:NSUTF8StringEncoding];
      
      responseString = [[AES AES256] decryptString:encryptedString withKey:encryptionKey];
    }
    else {
      responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    }
    
    responseObject = [responseString objectFromJSONStringWithParseOptions:JKParseOptionValidFlags];
   
    switch (type) {
      case DCHttpRequestTypeGET:
        if (allowsLogResponseGET) {
          NSLog(@"\nmethod:%@\nstatusCode:%d\n%@\n\n", method, statusCode, responseString);
        }
        break;
      case DCHttpRequestTypePOST:
        if (allowsLogResponsePOST) {
          NSLog(@"\nmethod:%@\nstatusCode:%d\n%@\n\n", method, statusCode, responseString);
        }
        break;
      case DCHttpRequestTypeHEAD:
        if (allowsLogResponseHEAD) {
          NSLog(@"\nmethod:%@\nstatusCode:%d\n%@\n\n", method, statusCode, headerString);
        }
        break;
      default:
        break;
    }
    
    if (operation.response.statusCode == 200) {
      NSDictionary *error = responseObject[@"Error"];
      NSDictionary *data  = responseObject[@"Data"];
      
      if (error && ![error isKindOfClass:[NSNull class]]) {
        NSInteger  errCode = [error[@"Code"] integerValue];
        NSString  *errMsg  = error[@"Message"];
        if (allowsLogRequestError) {
          NSLog(@"\nmethod:%@\nerrorCode:%d\n%@\n\n", method, errCode, errMsg);
        }
        failure(errCode, errMsg, data);
      }
      else {
        success(data);
      }
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSInteger errCode = operation.response.statusCode;
    NSString *errMsg  = error.localizedDescription;
    if (allowsLogRequestError) {
      NSLog(@"\nmethod:%@\nerrorCode:%d\n%@\n\n", method, errCode, errMsg);
    }
    failure(errCode, errMsg, nil);
  }];
  
  [self start];
}

#pragma mark -
#pragma mark Private Methods

- (void)prepareGetRequest
{
  NSString *urlString = [self urlStringWithParams:self.completeParams];
  
  if (self.allowsLogMethod) {
    NSLog(@"\nGET\n%@\n\n", urlString);
  }
  
  self.request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
  self.request.HTTPMethod      = self.typeString;
  self.request.timeoutInterval = self.timeout;
  
  [self.additionalHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [self.request setValue:obj forHTTPHeaderField:key];
  }];
}

- (void)preparePostRequest
{
  NSString *urlString = [self urlStringWithParams:nil];
  id params = nil;
  
  AFHTTPRequestSerializer *httpSerializer = nil;
  
  if (self.isEncryptionEnabled) {
    httpSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString *paramsString    = [self.completeParams JSONString];
    NSString *encryptedString = [[AES AES256] encryptString:paramsString withKey:self.encryptionKey];
    params = [encryptedString dataUsingEncoding:NSUTF8StringEncoding];
  }
  else {
    httpSerializer = [AFJSONRequestSerializer serializer];
    params = [NSJSONSerialization JSONObjectWithData:[self.completeParams JSONData]
                                             options:NSJSONReadingMutableContainers
                                               error:nil];
  }
  
  AFgzipRequestSerializer *gzipSerializer = [AFgzipRequestSerializer serializerWithSerializer:httpSerializer];
  
  self.request = [gzipSerializer requestWithMethod:self.typeString
                                         URLString:urlString
                                        parameters:nil
                                             error:nil];
  
  [self.request setValue:@"application/x-gzip" forHTTPHeaderField:@"Content-Type"];
  
  [self.additionalHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [self.request setValue:obj forHTTPHeaderField:key];
  }];
  
  if (self.allowsLogMethod) {
    NSLog(@"\nPOST\n%@\n%@\n\n", urlString, [self.params JSONString]);
  }
  
  self.request.URL             = [NSURL URLWithString:urlString];
  self.request.HTTPMethod      = self.typeString;
  self.request.timeoutInterval = self.timeout;
  self.request.HTTPBody        = params;
}

- (NSString *)urlStringWithParams:(id)params
{
  NSMutableString *url = [NSMutableString string];
  
  [url appendFormat:@"%@/%@?", self.baseUrl, self.method];
  
  if ([params isKindOfClass:[NSDictionary class]]) {
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      NSString *val = [obj isKindOfClass:[NSString class]] ? [obj URLEncode] : obj;
      [url appendFormat:@"%@=%@&", key, val];
    }];
  }
  
  [url deleteCharactersInRange:NSMakeRange(url.length - 1, 1)];
  
  return url;
}

- (void)start
{
//  if (self.allowsLogHeader) {
//    NSLog(@"\nRequest Headers :\n%@", self.request.allHTTPHeaderFields);
//  }
  
  [[NSOperationQueue mainQueue] addOperation:self.operation];
}

#pragma mark -
#pragma mark Properties

- (AFHTTPRequestOperation *)operation
{
  if (!_operation) {
    _operation = [[AFHTTPRequestOperation alloc] initWithRequest:self.request];
    _operation.responseSerializer = [AFHTTPResponseSerializer serializer];
  }
  
  return _operation;
}

- (DCReachability *)reachability
{
  return [DCReachability getInstance];
}

- (NSString *)typeString
{
  NSString *str = nil;
  
  switch (self.type) {
    case DCHttpRequestTypeGET:
      str = @"GET";
      break;
    case DCHttpRequestTypePOST:
      str = @"POST";
      break;
    case DCHttpRequestTypeHEAD:
      str = @"HEAD";
      break;
    default:
      str = @"UNKNOWN";
      break;
  }
  
  return str;
}

- (id)completeParams
{
  id params = nil;
  if ([self.params isKindOfClass:[NSDictionary class]]) {
    params = [NSMutableDictionary dictionaryWithDictionary:self.params];
//    params[@"tik"] = @([[NSDate date] timeIntervalSince1970]);
  }
  else {
    params = self.params;
  }
  
  return params;
}

@end
