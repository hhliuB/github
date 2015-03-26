
/******************************************************************************
 *  @file   : OrgStorage.h
 *  @author : WANG JIE
 *  @date   : 2014-12-18
 *  @brief  : 架构数据存储
 ******************************************************************************/

#import "SFAStorage.h"

#import "OrgEntities.h"

@interface OrgStorage : SFAStorage

@property (nonatomic,strong) Employee * me;

@property (nonatomic,copy) NSArray *products;
@property (nonatomic,copy) NSArray *contacts;

+ (instancetype)getInstance;

@end
