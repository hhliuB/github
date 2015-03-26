
/******************************************************************************
 *  @file   : SysAPI.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-21
 *  @brief  : 系统数据接口
 ******************************************************************************/

#import "SysAPI.h"

#import "SYSCommonBiz.h"

@interface SysAPI ()

@property (nonatomic,strong) SYSCommonBiz * commonBiz;

@end

@implementation SysAPI

- (void)loadConfigs
{
  [self.commonBiz loadConfigs];
}

- (Config *)configForKey:(NSString *)key
{
  return [self.commonBiz configForKey:key];
}

- (BOOL)hasInitialized
{
  return [self.commonBiz hasInitialized];
}

- (void)setInitialized:(BOOL)initialized
{
  [self.commonBiz setInitialized:initialized];
}

- (BOOL)is3GOn
{
  return [self.commonBiz is3GOn];
}

- (void)set3GOn:(BOOL)on
{
  [self.commonBiz set3GOn:on];
}

- (void)clearCache
{
  [self clearPDFCache];
}

- (void)resetDevice
{
  [self.commonBiz resetUserDefaults];
  [self.commonBiz clearDatabase];
  [self clearDirectories];
}

#pragma mark - Private

- (void)clearPDFCache
{
  //  [self clearDirectoryAtPath:PDFBaseThumbDirectory()];
}

- (void)clearDirectories
{
  //Documents
  [self clearContentsOfDirectoryAtPath:DocumentsDirectory()];
  
  //Librarys/Cache
  [self clearContentsOfDirectoryAtPath:CachesDirectory()];
}

- (void)clearDirectoryAtPath:(NSString *)path
{
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if ([fileManager fileExistsAtPath:path]) {
    [fileManager removeItemAtPath:path error:nil];
  }
}

- (void)clearContentsOfDirectoryAtPath:(NSString *)path
{
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  
  NSArray *contents = [fileMgr contentsOfDirectoryAtPath:path error:nil];
  [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSString *file = [path stringByAppendingPathComponent:obj];
    
    if (![self.commonBiz isDatabasePath:file]) {
      [fileMgr removeItemAtPath:file error:nil];
    }
  }];
}

#pragma mark -
#pragma mark Properties

- (SYSCommonBiz *)commonBiz
{
  if (!_commonBiz) {
    _commonBiz = [SYSCommonBiz biz];
  }
  
  return _commonBiz;
}

@end
