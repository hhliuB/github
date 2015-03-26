
/******************************************************************************
 *  @file   : OrgCache.h
 *  @author : WANG JIE
 *  @date   : 2014-12-18
 *  @brief  : 架构数据缓存
 ******************************************************************************/

#import "SFACache.h"

#import "OrgEntities.h"

@interface OrgCache : SFACache

+ (instancetype)getInstance;

@property (nonatomic,strong) Employee * me;
@property (nonatomic,strong) NSArray  * subordinates;
@property (nonatomic,strong) NSArray  * managers;

@end
