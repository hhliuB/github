//
//  DCHttpRequest.h
//  DCHttpRequest
//
//  Created by Duke on 14-7-24.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DCHttpRequestType) {
  DCHttpRequestTypeGET,
  DCHttpRequestTypePOST,
  DCHttpRequestTypeHEAD,
  DCHttpRequestTypeOthers,
};

@interface DCHttpRequest : NSObject

@property (nonatomic,assign) DCHttpRequestType   type;
@property (nonatomic,copy)   NSString          * baseUrl; // 例：http://192.168.1.10:8258/service
@property (nonatomic,copy)   NSString          * method;
@property (nonatomic,copy)   id                  params;  // 可以是数组或字典
@property (nonatomic,assign) NSTimeInterval      timeout; // Default is 15.0.

- (instancetype)init;
+ (instancetype)request;

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

- (void)startWithSuccess:(void (^)(id result))success
                 failure:(void (^)(NSInteger errCode, NSString *errMsg, NSDictionary *userInfo))failure;

@property (nonatomic) BOOL allowsLogMethod;
@property (nonatomic) BOOL allowsLogHeader;

@property (nonatomic) BOOL allowsLogResponseGET;
@property (nonatomic) BOOL allowsLogResponsePOST;
@property (nonatomic) BOOL allowsLogResponseHEAD;

@property (nonatomic) BOOL allowsLogRequestError;

@property (nonatomic)      BOOL      isEncryptionEnabled;
@property (nonatomic,copy) NSString *encryptionKey;

@end
