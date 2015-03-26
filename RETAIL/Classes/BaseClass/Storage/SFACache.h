
/******************************************************************************
 *  @file   : SFACache.h
 *  @author : WANG JIE
 *  @date   : 2014-12-18
 *  @brief  : 数据缓存基类（抽象类）
 ******************************************************************************/

#import <Foundation/Foundation.h>

#import "DCResult.h"

@interface SFACache : NSObject

@property (nonatomic,strong) DCResult *result;

@end
