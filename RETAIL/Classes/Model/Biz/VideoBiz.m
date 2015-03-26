//
//  VideoBiz.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/26.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "VideoBiz.h"

#import "MainDatabaseOperation.h"

@interface VideoBiz()

@property (nonatomic,strong) MainDatabaseOperation *mainDataBaseOperation;

@end

@implementation VideoBiz

- (void)getVideos
{
  [self.mainDataBaseOperation getVideos:^{
    
  }];
}

- (MainDatabaseOperation *)mainDataBaseOperation
{
  return GetInstance(MainDatabaseOperation, _mainDataBaseOperation);
}

@end
