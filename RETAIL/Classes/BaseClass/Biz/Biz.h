
/******************************************************************************
 *  @file   : Biz.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-11
 *  @brief  : 业务逻辑基类（抽象类）
 ******************************************************************************/


#import <Foundation/Foundation.h>

#import "DCDatabase.h"

@interface Biz : NSObject

@property (nonatomic,readonly) DCDatabase *mainDatabase;

+ (instancetype)biz;
- (NSArray *)convertDBQueryResult:(NSArray *)queryResult toClass:(Class)objClass;

@end
