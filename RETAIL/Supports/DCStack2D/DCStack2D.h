//
//  DCStack2D.h
//  DCStack2D
//
//  Created by Duke Cui on 14/12/23.
//  Copyright (c) 2014年 Duke Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DCStack.h"

@interface DCStack2D : NSObject

- (instancetype)init;
+ (instancetype)stack2D;

- (void)pushStack;
- (void)pushStack:(DCStack *)stack;
- (DCStack *)popStack;

- (DCStack *)topStack;
- (DCStack *)bottomStack;

- (BOOL)containsStack:(DCStack *)stack;
- (BOOL)containsObject:(id)object;

- (void)clear;

- (void)enumerateStacksUsingBlock:(void (^)(DCStack *stack, BOOL *stop))block;

@property (nonatomic,readonly) NSUInteger length;
@property (nonatomic,readonly) BOOL       isEmpty;

@end
