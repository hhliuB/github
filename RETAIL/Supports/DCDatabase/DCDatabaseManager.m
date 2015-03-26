
#import "DCDatabaseManager.h"

#import "DCDatabase+PrivateMethods.h"

@implementation DCDatabaseManager
{
  NSMutableDictionary *_dbDict;
}

- (id)init
{
  self = [super init];
  
  if (self) {
    _dbDict = [NSMutableDictionary dictionary];
    _directory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"dir = %@",_directory);
  }
  
  return self;
}

- (DCDatabase *)database:(NSString *)identifier withKey:(NSString *)key
{
  DCDatabase *db = _dbDict[identifier];
  
  if (db == nil) {
    db = [self createDatabase:identifier withKey:key];
    _dbDict[identifier] = db;
  }
  
  return db;
}

- (DCDatabase *)createDatabase:(NSString *)identifier withKey:(NSString *)key
{
  DCDatabase *db = [[DCDatabase alloc] initWithIdentifer:identifier directory:self.directory];
  
  if (self.shouldEncryptDatabase && key.length > 0) {
    [db setKey:key];
  }
  
  [db updateTables];
  
  return db;
}

- (void)closeDatabase:(NSString *)identifier
{
  DCDatabase *db = _dbDict[identifier];
  [db close];
  [_dbDict removeObjectForKey:identifier];
}

#pragma mark -
#pragma mark Singleton Definition

static id instance = nil;

+ (instancetype)sharedManager
{
  @synchronized(self){
    if (!instance) {
      instance = [[self alloc] init];
    }
  }
  
  return instance;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
  @synchronized(self){
    if (!instance) {
      instance = [super allocWithZone:zone];
    }
  }
  
  return instance;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
  return self;
}

@end
