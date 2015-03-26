
/******************************************************************************
 *  @file   : Enumeration.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-08
 *  @brief  : 定义应用内通用的枚举
 ******************************************************************************/

#ifndef MVVMDemo_Enumeration_h
#define MVVMDemo_Enumeration_h

typedef NS_ENUM(NSInteger, DocumentOrderType) {
  DocumentOrderByName,
  DocumentOrderBySize
};

#ifndef __Direction_Enumerate__
#define __Direction_Enumerate__
typedef NS_ENUM(NSInteger, Direction) {
  DirectionUnknown,
  DirectionTop,
  DirectionBottom,
  DirectionLeft,
  DirectionRight
};
#endif

#ifndef __AMPM_Enumerate__
#define __AMPM_Enumerate__
typedef NS_ENUM(NSInteger, AMPM) {
  AM,
  PM
};
#endif

#endif
