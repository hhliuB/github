
#import <Foundation/Foundation.h>

@interface DCObject : NSObject <NSCopying>

- (instancetype)init;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

- (NSDictionary *)undefinedProperties;

+ (NSArray *)properties;

@end

