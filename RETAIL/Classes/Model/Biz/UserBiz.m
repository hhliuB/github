//
//  UserBiz.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "UserBiz.h"

#import "MainDatabaseOperation.h"

#import "Entities.h"

@interface UserBiz()

@property (nonatomic,strong) MainDatabaseOperation *databaseOperation;

@end

@implementation UserBiz

- (void)getUserDetailedInformation
{
//  [self.databaseOperation getUserDetailedInformationWithUser:<#(NSString *)#> access_token:<#(NSString *)#>
}

- (void)selectUserInformation
{
  NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ \
                                              ",[User tableName]];
  NSArray *result = [self.mainDatabase query:sql];
  _me = [[User alloc]initWithDictionary:[result lastObject]];
}

- (MainDatabaseOperation *)databaseOperation
{
  if (!_databaseOperation) {
    _databaseOperation = [MainDatabaseOperation operationWithDatabase:self.mainDatabase];
  }
  return _databaseOperation;
}

@end
