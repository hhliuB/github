//
//  DCTableView+DataSourceCaller.m
//  DCTableView
//
//  Created by Duke on 13-9-13.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCTableView+DataSourceCaller.h"

@implementation DCTableView (DataSourceCaller)

- (DCTableViewCell *)createCellAtIndexPath:(NSIndexPath *)indexPath
{
  return (DCTableViewCell *)[self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
}

- (BOOL)shouldSlideToLeftAtIndexPath:(NSIndexPath *)indexPath
{
  if ([self.dataSource respondsToSelector:@selector(tableView:shouldSlideCellToLeftAtIndexPath:)]) {
    return [self.dataSource tableView:self shouldSlideCellToLeftAtIndexPath:indexPath];
  }
  
  return NO;
}

- (BOOL)shouldSlideToRightAtIndexPath:(NSIndexPath *)indexPath
{
  if ([self.dataSource respondsToSelector:@selector(tableView:shouldSlideCellToRightAtIndexPath:)]) {
    return [self.dataSource tableView:self shouldSlideCellToRightAtIndexPath:indexPath];
  }
  
  return NO;
}

@end
