
/******************************************************************************
 *  @file   : SysCache.h
 *  @author : WANG JIE
 *  @date   : 2014-12-18
 *  @brief  : 系统数据缓存
 ******************************************************************************/

#import "SFACache.h"

@interface SysCache : SFACache

+ (instancetype)getInstance;

@property (nonatomic,copy) NSArray *configs;

@end
