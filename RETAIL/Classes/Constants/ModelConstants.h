
/******************************************************************************
 *  @file   : ModelConstants.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-10
 *  @brief  : 定义数据相关的常量及宏
 *            包括但不限于目录位置、host地址、测试账号、错误信息、文件扩展名等
 ******************************************************************************/


#import <UIKit/UIKit.h>

#ifndef ModelConstants_h
#define ModelConstants_h

#define kAppGroupIdentifier @"group.ideabinder.SFAEssentials"

NS_INLINE NSString * AppGroupDirectory()
{
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  NSURL *url = [fileMgr containerURLForSecurityApplicationGroupIdentifier:kAppGroupIdentifier];
  return [url path];
}

NS_INLINE NSString * AppGroupDocumentsDirectory()
{
  return [AppGroupDirectory() stringByAppendingPathComponent:@"Documents"];
}

NS_INLINE NSString * AppGroupDocumentsPathOfFile(NSString *file)
{
  return [AppGroupDocumentsDirectory() stringByAppendingPathComponent:file];
}

#define kBizBuildForDebug 1

#if kBizBuildForDebug
static NSString *kDefaultHost    = @"http://www.sfaessentials.com/service";
static NSString *kDefaultHostId  = @"DefaultHost";
//static NSString *<#kAnotherHost#>   = @"<#AnotherHost#>";
//static NSString *kAnotherHostId  = @"<#AnotherHostId#>";

static BOOL      kUseTestAccount = YES;
static NSString *kTestUsername   = @"92010951";
static NSString *kTestPassword   = @"123";

#else

static NSString *kDefaultHost    = @"http://www.sfaessentials.com/service";
static NSString *kDefaultHostId  = @"DefaultHost";
//static NSString *<#kAnotherHost#>   = @"<#AnotherHost#>";
//static NSString *kAnotherHostId  = @"<#AnotherHostId#>";

static BOOL       kUseTestAccount = YES;
static NSString *kTestUsername    = @"92010951";
static NSString *kTestPassword    = @"123";

#endif

//#define kAppId @"<#AppID#>"
#define kAppId @"SFAWKCTR"

// Config Keys
#define kConfigKeyHost                 @"Host"

#define kConfigKeySkipAuthTimeInterval @"SkipAuthTimeInterval"
#define kConfigKeyMaxOfflineTime       @"<#xxx#>MaxOfflineTime"

//#define kConfigKey<#AnotherConfig#>       @"<#AnotherConfig#>" // <#Comments#>

// UserDefaults Keys
#define kUserDefaultsKeyHasInitialized  @"hasInitialized"
#define kUserDefaultsKey3GOn            @"3GOn"
#define kUserDefaultsKeyLastUserName    @"LastUserName"

// Error Codes
#define kErrorClientArgumentError        -114
#define kErrorRequireAuthorizationHeader 10100
#define kErrorWrongClientTime            10101
#define kErrorWrongPassword              10102
#define kErrorNoUser                     10106
#define kErrorNotAllowedDevice           10103//用户与设备不匹配
#define kErrorDeviceUnregistered         10107
#define kErrorUserLocked                 10104
#define kErrorDeviceLocked               10105
#define kErrorWrongUser                  -101//reset
#define kErrorFirstLoginCannotOffline    -10001
#define kErrorOfflineTimeExceedLimit     -10002
#define kErrorAppForbid                  10201
#define kErrorNeedUpdate                 10202
#define kErrorRegisterPushNotiFail       10902
// ...

typedef NSString* DCFileExtension;
static DCFileExtension PNG  = @"png";
static DCFileExtension JPG  = @"jpg";
static DCFileExtension GIF  = @"gif";
static DCFileExtension PDF  = @"pdf";
static DCFileExtension MP3  = @"mp3";
static DCFileExtension MP4  = @"mp4";
static DCFileExtension ZIP  = @"zip";
static DCFileExtension DOC  = @"doc";
static DCFileExtension DOCX = @"docx";
static DCFileExtension XLS  = @"xls";
static DCFileExtension XLSX = @"xlsx";
static DCFileExtension PPT  = @"ppt";
static DCFileExtension PPTX = @"pptx";
static DCFileExtension HTML = @"html";
static DCFileExtension TXT  = @"txt";

NS_INLINE UIImage *UIImageNamed(NSString *imageName, DCFileExtension extension) {
  NSString *path = [[NSBundle mainBundle] pathForResource:imageName
                                                   ofType:extension];
  return [UIImage imageWithContentsOfFile:path];
}

#endif
