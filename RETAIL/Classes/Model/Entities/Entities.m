//
//  Entities.m
//  MVVMDemo
//
//  Created by Duke Cui on 14/12/5.
//  Copyright (c) 2014年 Duke Cui. All rights reserved.
//

#import "Entities.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  if (self) {
    NSDictionary *props = [self undefinedProperties];
    
    NSString *description = props[@"description"];
    if (description) {
      _uDescription = description;
    }
  }
  return self;
}

@end

@implementation Video

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  if (self) {
    NSDictionary *props = [self undefinedProperties];
    
    NSString *description = props[@"description"];
    if (description) {
      _vDescription = description;
    }
  }
  return self;
}

@end
