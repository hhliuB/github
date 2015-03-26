
/******************************************************************************
 *  @file   : OrgCache.m
 *  @author : WANG JIE
 *  @date   : 2014-12-18
 *  @brief  : 架构数据缓存
 ******************************************************************************/

#import "OrgCache.h"

@implementation OrgCache

#pragma mark -
#pragma mark Singleton Definition

static id instance = nil;

+ (instancetype)getInstance
{
  @synchronized(self){
    if (!instance) {
      instance = [[self alloc] init];
    }
  }
  
  return instance;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
  @synchronized(self){
    if (!instance) {
      instance = [super allocWithZone:zone];
    }
  }
  
  return instance;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
  return self;
}

@end
