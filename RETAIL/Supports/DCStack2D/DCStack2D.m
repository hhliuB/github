//
//  DCStack2D.m
//  DCStack2D
//
//  Created by Duke Cui on 14/12/23.
//  Copyright (c) 2014年 Duke Cui. All rights reserved.
//

#import "DCStack2D.h"

@interface DCStack2D ()

@property (nonatomic,strong) NSMutableArray *stacks;

@end

@implementation DCStack2D

- (instancetype)init
{
  return [super init];
}

+ (instancetype)stack2D
{
  return [[DCStack2D alloc] init];
}

- (void)pushStack
{
  DCStack *stack = [[DCStack alloc] init];
  [self pushStack:stack];
}

- (void)pushStack:(DCStack *)stack
{
  [self.stacks addObject:stack];
}

- (DCStack *)popStack
{
  DCStack *stack = [self.stacks lastObject];
  [self.stacks removeLastObject];
  return stack;
}

- (DCStack *)topStack
{
  return [self.stacks lastObject];
}

- (DCStack *)bottomStack
{
  return [self.stacks firstObject];
}

- (BOOL)containsStack:(DCStack *)stack
{
  return [self.stacks containsObject:stack];
}

- (BOOL)containsObject:(id)object
{
  __block BOOL contains = NO;
  
  [self enumerateStacksUsingBlock:^(DCStack *stack, BOOL *stop) {
    contains = [stack contains:object];
    *stop = contains;
  }];
  
  return contains;
}

- (void)clear
{
  [self.stacks removeAllObjects];
}

- (void)enumerateStacksUsingBlock:(void (^)(DCStack *, BOOL *))block
{
  [self.stacks enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:
   ^(id obj, NSUInteger idx, BOOL *stop) {
     block(obj, stop);
  }];
}

#pragma mark -
#pragma mark Properties

- (NSMutableArray *)stacks
{
  if (!_stacks) {
    _stacks = [NSMutableArray array];
  }
  
  return _stacks;
}

- (NSUInteger)length
{
  return self.stacks.count;
}

- (BOOL)isEmpty
{
  return self.length == 0;
}

#pragma mark -
#pragma mark Description

- (NSString *)description
{
  NSMutableString *str = [NSMutableString string];
  
  [str appendFormat:@"\n< DCStack2D : %p >", self];
  [str appendString:@"\n{"];
  
  if (!self.isEmpty) {
    [self enumerateStacksUsingBlock:^(DCStack *stack, BOOL *stop) {
      [str appendFormat:@"\n%@,", stack];
    }];
    [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
  }
  
  [str appendString:@"\n}"];
  
  return str;
}

@end
