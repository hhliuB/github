
/******************************************************************************
 *  @file   : API.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-13
 *  @brief  : 业务接口基类（抽象类）
 ******************************************************************************/

#import "API.h"

@interface API ()

@property (nonatomic,strong,readwrite) NSOperationQueue *operationQueue;

@end

@implementation API

- (instancetype)init
{
  self = [super init];
  if (self) {
    _operationQueue = [[NSOperationQueue alloc] init];
    _operationQueue.maxConcurrentOperationCount = 1;
  }
  return self;
}

+ (instancetype)api
{
  return [[self alloc] init];
}

@end
