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
  [self.databaseOperation configValueForKey:@"nme"];
  [self.bizOperation getUserDetailedInformation:^{
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
  
  return [MainDatabaseOperation operationWithDatabase:self.orgDatabase];
}

@end
