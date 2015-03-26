
/******************************************************************************
 *  @file   : DebugConfigs.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-05
 *  @brief  : 定义调试相关的宏，包括是否允许登录、是否允许 log 输出等
 ******************************************************************************/


#ifndef SFAExample_DebugConfigs_h
#define SFAExample_DebugConfigs_h

/**
 *  Login
 */
#pragma mark -
#pragma mark Login

#define kLoginEnabled 0

/**
 *  Log Configs
 */
#pragma mark -
#pragma mark Log Configs

#define kLogEnabled      1
#define kIConsoleEnabled 0

#if kLogEnabled
  #if kIConsoleEnabled
    #import "iConsole.h"
    #define NSLog(fmt, ...) [iConsole log:(fmt),##__VA_ARGS__]
  #endif
#else
  #define NSLog(fmt, ...)
#endif

/**
 *  HttpRequest Logs
 */
#define kHttpRequestAllowsLogMethod       YES
#define kHttpRequestAllowsLogHeader       YES

#define kHttpRequestAllowsLogResponseGET  YES
#define kHttpRequestAllowsLogResponsePOST YES
#define kHttpRequestAllowsLogResponseHEAD YES

#define kHttpRequestAllowsLogRequestError YES

/**
 * Database Logs
 */
#define kDatabaseAllowsLogStatement       NO
#define kDatabaseAllowsLogError           NO


#endif
