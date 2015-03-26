//
//  UserBizOperation.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "UserBizOperation.h"
#import "AFNetworking.h"

@implementation UserBizOperation

- (void)getUserDetailedInformation:(void (^)())completion
{

  NSDictionary *params = @{@"client_id"     : @"e0d3d0729883df01",
                           @"access_token"  : @"026623ad9d07ef1f763dc096b02c1164"};
  
  AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

  
  [mgr POST:@"https://openapi.youku.com/v2/users/myinfo.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
    NSLog(@"%@",responseObject);


    completion();

  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"请求失败--%@",error);
  }];
  
//  DCHttpRequest *request = [self postRequestWithBaseUrl:@"https://openapi.youku.com/v2/users"
//                                                 method:@"myinfo.json"
//                                                 params:params];
//  
//  [request startWithSuccess:^(id result) {
//    NSLog(@"%@",result);
//    completion();
//  } failure:^(NSInteger errCode, NSString *errMsg, NSDictionary *userInfo) {
//    NSLog(@"请求失败--%@",error);
//    completion();
//  }];
  
}

@end
