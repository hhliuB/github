//
//  DCMultiTableView+DataSourceCaller.m
//  DCMultiTableView
//
//  Created by Duke on 13-11-8.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCMultiTableView+DataSourceCaller.h"

@implementation DCMultiTableView (DataSourceCaller)

- (NSInteger)numberOfTableViews
{
  return [self.dataSource numberOfTableViewsForMultiTableView:self];
}

- (CGRect)frameForTableViewAtIndex:(NSInteger)index
{
  return [self.dataSource multiTableView:self frameForTableViewAtIndex:index];
}

- (id<UITableViewDataSource>)dataSourceForTableViewAtIndex:(NSInteger)index
{
  return [self.dataSource multiTableView:self dataSourceForTableViewAtIndex:index];
}

- (id<UITableViewDelegate>)delegateForTableViewAtIndex:(NSInteger)index
{
  return [self.dataSource multiTableView:self delegateForTableViewAtIndex:index];
}

- (Class)registerTableViewClassAtIndex:(NSInteger)index
{
  if ([self.dataSource respondsToSelector:@selector(multiTableView:registerTableViewClassAtIndex:)]) {
    return [self.dataSource multiTableView:self registerTableViewClassAtIndex:index];
  }
  
  return [UITableView class];
}

- (UITableView *)customizeTableView:(UITableView *)tableView
{
  if ([self.dataSource respondsToSelector:@selector(multiTableView:customizeTableView:)]) {
    return [self.dataSource multiTableView:self customizeTableView:tableView];
  }
  
  return tableView;
}

@end
