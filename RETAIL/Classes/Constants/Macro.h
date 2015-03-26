
/******************************************************************************
 *  @file   : Macro.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-05
 *  @brief  : 定义程序内通用的宏
 ******************************************************************************/

#ifndef MVVMDemo_GlobalMacro_h
#define MVVMDemo_GlobalMacro_h

#define GetInstance(class, instance) ({if ((instance) == nil) (instance) = [[class alloc] init]; (instance);})

#endif
