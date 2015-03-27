
/******************************************************************************
 *  @file   : Biz.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-11
 *  @brief  : 业务逻辑基类（抽象类）
 ******************************************************************************/

#import "Biz.h"

#import "DCDB.h"

#define kMainDatabase     @"main.db"

@interface Biz ()

@property (nonatomic,strong) DCDatabaseManager *databaseManager;
@property (nonatomic,strong) DCDatabase        *mainDatabase;

@end

@implementation Biz

+ (instancetype)biz
{
  return [[self alloc] init];
}

- (NSArray *)convertDBQueryResult:(NSArray *)queryResult toClass:(Class)objClass
{
  NSMutableArray *result = [NSMutableArray arrayWithCapacity:[queryResult count]];
  
  for (NSDictionary *dict in queryResult) {
    id object = [[objClass alloc] initWithDictionary:dict];
    [result addObject:object];
  }
  
  return result;
}

#pragma mark -
#pragma mark Properties

#pragma mark Database

- (DCDatabaseManager *)databaseManager
{
  if (!_databaseManager) {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
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

- (DCDatabase *)mainDatabase
{
  if (!_mainDatabase) {
    _mainDatabase = [self database:kMainDatabase withKey:nil];
  }
  
  _mainDatabase.allowsLogStatement = kDatabaseAllowsLogStatement;
  _mainDatabase.allowsLogError     = kDatabaseAllowsLogError;
  
  return _mainDatabase;
}

- (DCDatabase *)database:(NSString *)identifier withKey:(NSString *)key
{
  DCDatabase *database = [self.databaseManager database:identifier withKey:key];
  return database;
}

@end
