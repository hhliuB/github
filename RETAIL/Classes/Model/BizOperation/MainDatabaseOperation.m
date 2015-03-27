//
//  MainDatabaseOperation.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "MainDatabaseOperation.h"

#import "AFNetworking.h"

#import "Entities.h"
#import "Biz.h"

#import "MJExtension.h"

#import "JSONKit.h"

#define kVideosCategory @"https://openapi.youku.com/v2/videos/by_category.json"
#define kUser @"https://openapi.youku.com/v2/users/myinfo.json"

#define kClient_id @"e0d3d0729883df01"

@interface MainDatabaseOperation()

@property (nonatomic,strong) Biz *biz;

@end



@implementation MainDatabaseOperation

- (void)getUserDetailedInformationWithUser:(NSString *)client_id
                              access_token:(NSString *)access_token
{
  NSDictionary *params = @{@"client_id"     :client_id,
                           @"access_token"  :access_token};
  
  AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
  
  
  [mgr POST:kUser parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
    NSLog(@"%@",responseObject);
    
    
    User *user = [[User alloc]initWithDictionary:responseObject];
    
    [self.biz.mainDatabase updateObjects:@[user]];
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"请求失败--%@",error);
  }];
}

- (void)getVideosWithCategory:(NSString *)category
                         page:(int)page
                        count:(int)count
{
  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
  [params setObject:@"e0d3d0729883df01" forKey:@"client_id"];
  
  NSLog(@"%@",params);
  
  AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
  
  [mgr GET:kVideosCategory parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    NSDictionary *results;
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
      results = (NSDictionary *)responseObject;
      
      NSArray *array = results[@"videos"];
      NSMutableArray *videos = [NSMutableArray arrayWithCapacity:array.count];

      [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        Video *video = [[Video alloc] initWithDictionary:obj];
        video.createTime = [Now() milliseconds];
        video.isActive = YES;
        [videos addObject:video];
      }];
      
      [self.biz.mainDatabase updateObjects:videos];
    }
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"请求失败--%@",error);
    
  }];
}

- (Biz *)biz
{
  if (!_biz) {
    _biz = [[Biz alloc]init];
  }
  return _biz;
}
@end
