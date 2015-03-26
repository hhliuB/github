
/******************************************************************************
 *  @file   : BizDatabaseOperation.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-20
 *  @brief  : 数据库业务操作基类（抽象类）
 ******************************************************************************/

#import "BizDatabaseOperation.h"

#import "DCDatabase.h"

@interface BizDatabaseOperation ()

@property (nonatomic,strong) DCDatabase *database;

@end

@implementation BizDatabaseOperation

+ (instancetype)operationWithDatabase:(DCDatabase *)database
{
  BizDatabaseOperation *operation = [[self alloc] init];
  operation.database = database;
  return operation;
}

@end
