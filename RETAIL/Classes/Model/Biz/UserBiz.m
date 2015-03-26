//
//  UserBiz.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "UserBiz.h"

#import "UserBizOperation.h"

#import "MainDatabaseOperation.h"

@interface UserBiz()

@property (nonatomic,strong) UserBizOperation *bizOperation;
@property (nonatomic,strong) MainDatabaseOperation *databaseOperation;

@end

@implementation UserBiz

- (void)getUserDetailedInformation
{
  [self.databaseOperation getUserDetailedInformation:^{
  }];
}

- (UserBizOperation *)bizOperation
{
  if (!_bizOperation) {
    _bizOperation = [[UserBizOperation alloc]init];
  }
  return _bizOperation;
}

- (MainDatabaseOperation *)databaseOperation
{
  if (!_databaseOperation) {
    _databaseOperation = [MainDatabaseOperation operationWithDatabase:self.mainDatabase];
  }
  return _databaseOperation;
}

@end
