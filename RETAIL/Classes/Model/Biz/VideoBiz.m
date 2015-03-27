//
//  VideoBiz.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/26.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "VideoBiz.h"

#import "MainDatabaseOperation.h"

#import "Entities.h"

@interface VideoBiz()

@property (nonatomic,strong) MainDatabaseOperation *dataBaseOperation;

@end

@implementation VideoBiz

- (void)getVideosWithCategory:(NSString *)category
                         page:(int)page
                        count:(int)count
{
  [self.dataBaseOperation getVideosWithCategory:category page:page count:count];
}

- (NSArray *)videosWithCategory:(NSString *)category
{
  NSArray *videos = nil;
  if (category.length == 0) {
    return @[@""];
  }
  NSString *sql = [NSString stringWithFormat:
                   @"SELECT * FROM %@           \
                   WHERE category =  ?          \
                   ORDER BY createTime",[Video tableName]];
  NSArray *result = [self.mainDatabase query:sql withArguments:@[category]];
  videos = [self convertDBQueryResult:result toClass:[Video class]];
  return videos;
}

- (MainDatabaseOperation *)dataBaseOperation
{
  if (!_dataBaseOperation) {
    _dataBaseOperation = [MainDatabaseOperation operationWithDatabase:self.mainDatabase];
  }
  return _dataBaseOperation;
}

@end
