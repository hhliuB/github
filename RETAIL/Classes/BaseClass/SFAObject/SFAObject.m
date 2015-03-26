
/******************************************************************************
 *  @file   : SFAObject.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-23
 *  @brief  : SFA 相关应用的数据实体基类
 ******************************************************************************/

#import "SFAObject.h"

@implementation SFAObject

- (BOOL)isEquatToSFAObject:(SFAObject *)object
{
  BOOL isEqual = YES;
  
  NSArray *primaryKeys = [[self class] primaryKeys];
  for (NSString *key in primaryKeys) {
    id value1 = [self   valueForKey:key];
    id value2 = [object valueForKey:key];
    if ([value1 compare:value2] != NSOrderedSame) {
      isEqual = NO;
      break;
    }
  }
  
  return isEqual;
}

@end
