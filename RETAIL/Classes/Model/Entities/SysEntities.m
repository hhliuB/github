
/******************************************************************************
 *  @file   : SysEntities.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-10-23
 *  @brief  : 系统数据实体类集合
 ******************************************************************************/

#import "SysEntities.h"

@implementation Config

+ (NSArray *)primaryKeys
{
  return @[@"key"];
}

+ (NSArray *)propertiesOutOfDatabase
{
  return @[@"createTime", @"updateTime", @"isActive"];
}

@end


@implementation Host

+ (NSArray *)propertiesOutOfDatabase
{
  return @[@"createTime", @"updateTime", @"isActive"];
}

@end

@implementation SysCode

@end

@implementation LatestUpdateTime

+ (NSArray *)propertiesOutOfDatabase
{
  return @[@"createTime", @"updateTime", @"isActive"];
}

+ (NSArray *)primaryKeys
{
  return @[@"Id", @"type"];
}

@end
