
#import "DCDatabaseObject.h"

@implementation DCDatabaseObject

+ (NSString *)tableName
{
  return NSStringFromClass([self class]);
}

+ (NSArray *)propertiesOutOfDatabase
{
  return nil;
}

+ (NSArray *)primaryKeys
{
  return @[@"Id"];
}

@end
