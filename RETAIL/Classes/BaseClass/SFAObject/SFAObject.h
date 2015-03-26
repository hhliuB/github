
/******************************************************************************
 *  @file   : SFAObject.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-23
 *  @brief  : SFA 相关应用的数据实体基类
 ******************************************************************************/

#import "DCDatabaseObject.h"

@interface SFAObject : DCDatabaseObject

@property long long createTime;
@property long long updateTime;
@property BOOL      isActive;

- (BOOL)isEquatToSFAObject:(SFAObject *)object;

@end
