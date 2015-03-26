
/******************************************************************************
 *  @file   : BizDatabaseOperation.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-20
 *  @brief  : 数据库业务操作基类（抽象类）
 ******************************************************************************/

#import "BizOperation.h"

#import "DCDatabase.h"

@interface BizDatabaseOperation : BizOperation

+ (instancetype)operationWithDatabase:(DCDatabase *)database;

@property (nonatomic,readonly) DCDatabase *database;

@end
