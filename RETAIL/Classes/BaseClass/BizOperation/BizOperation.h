
/******************************************************************************
 *  @file   : BizOperation.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-20
 *  @brief  : 业务操作基类（抽象类）
 ******************************************************************************/

#import <Foundation/Foundation.h>

@interface BizOperation : NSObject

- (NSArray *)convertDictionaries:(NSArray *)dictionaries toClass:(Class)objClass;

@end
