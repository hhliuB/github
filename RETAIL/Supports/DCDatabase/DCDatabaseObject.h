
#import "DCObject.h"

@interface DCDatabaseObject : DCObject

+ (NSString *)tableName;

+ (NSArray *)propertiesOutOfDatabase;
+ (NSArray *)primaryKeys;

@end
