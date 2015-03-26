//
//  UserViewModel.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "UserViewModel.h"

#import "UserAPI.h"

@interface UserViewModel()

@property (nonatomic,strong) UserAPI *userAPI;

@end

@implementation UserViewModel

- (void)loadData:(void (^)())completion
{
  [self.userAPI getUserDetailedInformation];

}


- (UserAPI *)userAPI
{
  if (!_userAPI) {
    _userAPI = [[UserAPI alloc]init];
  }
  return _userAPI;
}

@end

