#import "DCStack.h"

@interface DCStack ()

@property (nonatomic,strong) NSMutableArray *objects;

@end

@implementation DCStack

- (instancetype)init
{
  return [super init];
}

+ (instancetype)stack
{
  return [[DCStack alloc] init];
}

- (void)push:(id)object
{
  [self.objects addObject:object];
}

- (id)pop
{
  id object = [self top];
  [self.objects removeLastObject];
  return object;
}

- (id)top
{
  return [self.objects lastObject];
}

- (id)bottom
{
  return [self.objects firstObject];
}

- (BOOL)contains:(id)object
{
  return [self.objects containsObject:object];
}

- (void)clear
{
  [self.objects removeAllObjects];
}

- (void)enumerateObjectsUsingBlock:(void (^)(id, BOOL *))block {
  [self.objects enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:
   ^(id obj, NSUInteger idx, BOOL *stop) {
     block(obj, stop);
   }];
}

#pragma mark -
#pragma mark Properties

- (NSMutableArray *)objects
{
  if (!_objects) {
    _objects = [NSMutableArray array];
  }
  
  return _objects;
}

- (NSUInteger)length {
  return self.objects.count;
}

- (BOOL)isEmpty {
  return self.length == 0;
}

#pragma mark -
#pragma mark Description

- (NSString *)description
{
  NSMutableString *str = [NSMutableString string];
  
  [str appendFormat:@"\n< DCStack : %p >", self];
  [str appendString:@"\n{"];
  
  if (!self.isEmpty) {
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
      [str appendFormat:@"\n  %@,", obj];
    }];
    [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
  }
  
  [str appendString:@"\n}"];
  
  return str;
}

@end
