//
//  DCMultiTableView+DelegateCaller.m
//  DCMultiTableView
//
//  Created by Duke on 13-11-8.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCMultiTableView+DelegateCaller.h"

@implementation DCMultiTableView (DelegateCaller)

// @required

- (void)willMoveCellFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                             atIndexPath:(NSIndexPath *)indexPath
{
  [self.delegate multiTableView:self
      willMoveCellFromTableViewAtIndex:srcTableViewIndex
                           atIndexPath:indexPath];
}

- (void)willRestoreCellToTableViewAtIndex:(NSInteger)tableViewIndex
                              atIndexPath:(NSIndexPath *)indexPath
{
  [self.delegate multiTableView:self
       willRestoreCellToTableViewAtIndex:tableViewIndex
                             atIndexPath:indexPath];
}

- (void)willMoveCellToTableViewAtIndex:(NSInteger)destTableViewIndex
                           atIndexPath:(NSIndexPath *)indexPath
{
  [self.delegate multiTableView:self
      willMoveCellToTableViewAtIndex:destTableViewIndex
                         atIndexPath:indexPath];
}

// @optional

- (BOOL)shouldDeleteCellAfterMoveFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                                          atIndexPath:(NSIndexPath *)indexPath
{
  SEL selector = @selector(multiTableView:shouldDeleteCellAfterMoveFromTableViewAtIndex:atIndexPath:);
  if ([self.delegate respondsToSelector:selector]) {
    return [self.delegate multiTableView:self
               shouldDeleteCellAfterMoveFromTableViewAtIndex:srcTableViewIndex
                                                 atIndexPath:indexPath];
  }
  
  return NO;
}

- (void)willDeleteCellFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                               atIndexPath:(NSIndexPath *)indexPath
{
  SEL selector = @selector(multiTableView:willDeleteCellFromTableViewAtIndex:atIndexPath:);
  if ([self.delegate respondsToSelector:selector]) {
    [self.delegate multiTableView:self
         willDeleteCellFromTableViewAtIndex:srcTableViewIndex
                                atIndexPath:indexPath];
  }
}

- (BOOL)allowsMoveCellFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                               atIndexPath:(NSIndexPath *)indexPath
{
  SEL selector = @selector(multiTableView:allowsMoveCellFromTableViewAtIndex:atIndexPath:);
  if ([self.delegate respondsToSelector:selector]) {
    return [self.delegate multiTableView:self
                allowsMoveCellFromTableViewAtIndex:srcTableViewIndex
                                       atIndexPath:indexPath];
  }
  
  return YES;
}

- (BOOL)allowsMoveCellToTableViewAtIndex:(NSInteger)destTableViewIndex
                             atIndexPath:(NSIndexPath *)indexPath
{
  SEL selector = @selector(multiTableView:allowsMoveCellToTableViewAtIndex:atIndexPath:);
  if ([self.delegate respondsToSelector:selector]) {
    return [self.delegate multiTableView:self
                allowsMoveCellToTableViewAtIndex:destTableViewIndex
                                     atIndexPath:indexPath];
  }
  
  return YES;
}

- (NSIndexPath *)indexPathToMoveForCellAtTableViewWithIndex:(NSInteger)destTableViewIndex
{
  NSIndexPath *indexPath = nil;
  
  SEL selector = @selector(multiTableView:indexPathToMoveForCellAtTableViewWithIndex:);
  if ([self.delegate respondsToSelector:selector]) {
    indexPath = [self.delegate multiTableView:self
                                 indexPathToMoveForCellAtTableViewWithIndex:destTableViewIndex];
  }
  
  if (!indexPath) {
    UITableView *tableView = [self tableViewAtIndex:destTableViewIndex];
    NSInteger section = [tableView numberOfSections] - 1;
    NSInteger row = [tableView numberOfRowsInSection:section];
    indexPath = [NSIndexPath indexPathForRow:row inSection:section];
  }
  
  return indexPath;
}

- (void)didMoveCellToTableViewAtIndex:(NSInteger)destTableViewIndex
                          atIndexPath:(NSIndexPath *)indexPath
{
  SEL selector = @selector(multiTableView:didMoveCellToTableViewAtIndex:atIndexPath:);
  if ([self.delegate respondsToSelector:selector]) {
    [self.delegate multiTableView:self
         didMoveCellToTableViewAtIndex:destTableViewIndex
                           atIndexPath:indexPath];
  }
}

@end
