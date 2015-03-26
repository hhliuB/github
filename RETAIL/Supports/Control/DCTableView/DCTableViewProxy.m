//
//  DCTableViewProxy.m
//  DCTableView
//
//  Created by Duke on 13-11-13.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCTableViewProxy.h"

@implementation DCTableViewProxy

- (id)forwardingTargetForSelector:(SEL)aSelector
{
  if ([self.middleMan respondsToSelector:aSelector]) {
    return self.middleMan;
  }
  
  if ([self.dataSource respondsToSelector:aSelector]) {
    return self.dataSource;
  }
  
  if ([self.delegate respondsToSelector:aSelector]) {
    return self.delegate;
  }
  
  return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
  if ([self.middleMan respondsToSelector:aSelector]) {
    return YES;
  }
  
  if ([self.dataSource respondsToSelector:aSelector]) {
    return YES;
  }
  
  if ([self.delegate respondsToSelector:aSelector]) {
    return YES;
  }
  
  return [super respondsToSelector:aSelector];
}

@end
