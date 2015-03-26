
/******************************************************************************
 *  @file   : Biz.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-11
 *  @brief  : 业务逻辑基类（抽象类）
 ******************************************************************************/

#import "Biz.h"

#import "DCDB.h"

#define kSysDatabase     @"sys.db"
#define kLoginDatabase   @"login.db"
#define kOrgDatabase     @"org.db"
#define kLibraryDatabase @"library.db"
#define kCallDatabase    @"call.db"

@interface Biz ()

@property (nonatomic,strong) DCDatabaseManager *databaseManager;
@property (nonatomic,strong) DCDatabase        *sysDatabase;
@property (nonatomic,strong) DCDatabase        *loginDatabase;
@property (nonatomic,strong) DCDatabase        *orgDatabase;
@property (nonatomic,strong) DCDatabase        *libraryDatabase;
@property (nonatomic,strong) DCDatabase        *callsDatabase;

@end

@implementation Biz

+ (instancetype)biz
{
  return [[self alloc] init];
}

#pragma mark -
#pragma mark Properties

#pragma mark Database

- (DCDatabaseManager *)databaseManager
{
  if (!_databaseManager) {
    NSString *path = AppGroupDocumentsDirectory();
    
    [[NSFileManager defaultManager] createDirectoryAtPath:path
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    
    _databaseManager = [DCDatabaseManager sharedManager];
    _databaseManager.directory = path;
    NSLog(@"path = %@",path);
  }
  
  return _databaseManager;
}

- (DCDatabase *)sysDatabase
{
  if (!_sysDatabase) {
    _sysDatabase= [self database:kSysDatabase withKey:nil];
  }
  
  _sysDatabase.allowsLogStatement = kDatabaseAllowsLogStatement;
  _sysDatabase.allowsLogError     = kDatabaseAllowsLogError;
  
  return _sysDatabase;
}

- (DCDatabase *)loginDatabase
{
  if (!_loginDatabase) {
    _loginDatabase = [self database:kLoginDatabase withKey:nil];
  }
  
  _loginDatabase.allowsLogStatement = kDatabaseAllowsLogStatement;
  _loginDatabase.allowsLogError     = kDatabaseAllowsLogError;
    
  return _loginDatabase;
}

- (DCDatabase *)orgDatabase
{
  if (!_orgDatabase) {
    _orgDatabase = [self database:kOrgDatabase withKey:nil];
  }
  
  _orgDatabase.allowsLogStatement = kDatabaseAllowsLogStatement;
  _orgDatabase.allowsLogError     = kDatabaseAllowsLogError;
  
  return _orgDatabase;
}

- (DCDatabase *)libraryDatabase
{
  if (!_libraryDatabase) {
    _libraryDatabase = [self database:kLibraryDatabase withKey:nil];
  }
  
  _libraryDatabase.allowsLogStatement = kDatabaseAllowsLogStatement;
  _libraryDatabase.allowsLogError     = kDatabaseAllowsLogError;
  
  return _libraryDatabase;
}

- (DCDatabase *)callDatabase
{
  if (!_callsDatabase) {
    _callsDatabase = [self database:kCallDatabase withKey:nil];
  }
  
  _callsDatabase.allowsLogStatement = kDatabaseAllowsLogStatement;
  _callsDatabase.allowsLogError     = kDatabaseAllowsLogError;
  
  return _callsDatabase;
}

- (DCDatabase *)database:(NSString *)identifier withKey:(NSString *)key
{
  DCDatabase *database = [self.databaseManager database:identifier withKey:key];
  return database;
}

@end
