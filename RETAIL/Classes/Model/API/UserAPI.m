//
//  UserAPI.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "UserAPI.h"

#import "UserBiz.h"

@interface UserAPI()

@property (nonatomic,strong) UserBiz *biz;

@end

@implementation UserAPI

- (void)getUserDetailedInformation
{
  [self.biz getUserDetailedInformation];
}

- (UserBiz *)biz
{
  if (!_biz) {
    _biz = [[UserBiz alloc]init];
  }
  return _biz;
}

@end
