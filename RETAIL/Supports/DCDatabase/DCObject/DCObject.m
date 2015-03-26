
#import "DCObject.h"
#import "DCProperty.h"

#import "DCObjectCopyingAdditions.h"

#import <objc/runtime.h>

@interface DCObject ()
{
  NSMutableDictionary *_undefinedProperties;
}

+ (NSArray *)initProperties;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

@implementation DCObject

- (instancetype)init
{
  self = [super init];
 
  if (self) {
    _undefinedProperties = [NSMutableDictionary dictionary];
  }
  
  return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super init];
  
  if (self) {
    _undefinedProperties = [NSMutableDictionary dictionary];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      NSString *className = nil;
      
      NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", key];
      
      DCProperty *property = [[[[self class] properties] filteredArrayUsingPredicate:predicate] firstObject];
      className = property.type;
      Class class = NSClassFromString(className);
      if ([class isSubclassOfClass:[DCObject class]]) {
        DCObject *object = [[class alloc] initWithDictionary:obj];
        [self setValue:object forKey:key];
      }
      else {
        [self setValue:obj forKey:key];
      }
    }];
  }
  
  return self;
}

- (NSDictionary *)dictionary
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  NSArray *properties = [[self class] properties];
  
  for (DCProperty *property in properties) {
    NSString *key = property.name;
    id value = [self valueForKey:key];
    if (value != nil) {
      if ([value isKindOfClass:[DCObject class]]) {
        dictionary[key] = [value dictionary];
      }
      else if ([value isKindOfClass:[NSArray class]]) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[value count]];
        for (id v in value) {
          [arr addObject:[v isKindOfClass:[DCObject class]] ? [v dictionary] : v];
        }
        dictionary[key] = arr;
      }
      else if ([value isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:[value count]];
        [value enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
          dict[key] = [obj isKindOfClass:[DCObject class]] ? [obj dictionary] : obj;
        }];
        dictionary[key] = dict;
      }
      else if ([value isKindOfClass:[NSSet class]]) {
        NSMutableSet *set = [NSMutableSet setWithCapacity:[value count]];
        for (id obj in value) {
          [set addObject:[obj isKindOfClass:[DCObject class]] ? [obj dictionary] : obj];
        }
        dictionary[key] = set;
      }
      else {
        dictionary[key] = value;
      }
    }
  }
  
  return (NSDictionary *)dictionary;
}

- (NSDictionary *)undefinedProperties
{
  return _undefinedProperties;
}

+ (NSArray *)properties
{
  static NSMutableDictionary *propertyDictionary = nil;
  
  static dispatch_once_t onceToken = 0;
  dispatch_once(&onceToken, ^{
    propertyDictionary = [NSMutableDictionary dictionary];
  });
  
  NSArray *properties = propertyDictionary[NSStringFromClass(self)];
  
  if(properties == nil) {
    properties = [self initProperties];
    propertyDictionary[NSStringFromClass(self)] = properties;
  }
  
  return properties;
}

#pragma mark -
#pragma mark Private Methods

+ (NSArray *)initProperties
{
  unsigned int count;
  objc_property_t *properties = class_copyPropertyList(self, &count);
  NSMutableArray *propertyEntities = [NSMutableArray arrayWithCapacity:count];
  
  for (int i = 0; i < count; i++) {
    DCProperty *property = [[DCProperty alloc] initWithObjcProperty:properties[i]];
    [propertyEntities addObject:property];
  }
  
  free(properties);
  
  Class superclass = [self superclass];
  
  if ([superclass isSubclassOfClass:[DCObject class]]) {
    [propertyEntities addObjectsFromArray:[superclass properties]];
  }
  
  return propertyEntities;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
  if (value != nil) {
    _undefinedProperties[key] = value;
  }
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
  id copy = [[[self class] allocWithZone:zone] init];
  NSArray *properties = [[self class] properties];
  for (DCProperty *property in properties) {
    id value = [self valueForKey:property.name];
    Class class = NSClassFromString(property.type);
    
    if (kClassIsCollectionType(class)) {
      [copy setValue:[value dcobj_deepCopy] forKey:property.name];
    }
    else {
      [copy setValue:[value copy] forKey:property.name];
    }
  }
  
  return copy;
}

@end

