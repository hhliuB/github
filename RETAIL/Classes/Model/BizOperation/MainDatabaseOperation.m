//
//  MainDatabaseOperation.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "MainDatabaseOperation.h"

@implementation MainDatabaseOperation

- (NSString *)configValueForKey:(NSString *)key
{
  Config *config = [self configForKey:key];
  return config.value;
}

- (Config *)configForKey:(NSString *)key
{
  return [[Config alloc]init];
}

@end
