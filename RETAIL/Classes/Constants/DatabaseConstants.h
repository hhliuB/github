
/******************************************************************************
 *  @file   : DatabaseConstants.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-10-23
 *  @brief  : 定义数据库相关常量，包括数据库名称、是否加密及对应的密钥等
 ******************************************************************************/

#ifndef SFA_ESSENTIALS_TEMPLATE_DatabaseConstants_h
#define SFA_ESSENTIALS_TEMPLATE_DatabaseConstants_h

/**
 *  Database Identifiers
 */
#define kSysDatabase     @"sys.db"
#define kLoginDatabase   @"login.db"
#define kOrgDatabase     @"org.db"
#define kLibraryDatabase @"library.db"
//#define <#kAnotherDatabase#> @"<#another.db#>"

/**
 *  Database Encryption
 */
#define kDatabaseShouldEncrypt NO

#define kSysDatabaseKey     @"12345678901234567890123456789012"
#define kLoginDatabaseKey   @"12345678901234567890123456789012"
#define kOrgDatabaseKey     @"12345678901234567890123456789012"
#define kLibraryDatabaseKey @"12345678901234567890123456789012"
//#define <#kAnotherDatabaseKey#>  @"<#AnotherKey#>"

#endif
