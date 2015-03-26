//
//  DCMultiTableView+DelegateCaller.h
//  DCMultiTableView
//
//  Created by Duke on 13-11-8.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCMultiTableView.h"

@interface DCMultiTableView (DelegateCaller)

// @required

- (void)willMoveCellFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                             atIndexPath:(NSIndexPath *)indexPath;

- (void)willRestoreCellToTableViewAtIndex:(NSInteger)tableViewIndex
                              atIndexPath:(NSIndexPath *)indexPath;

- (void)willMoveCellToTableViewAtIndex:(NSInteger)destTableViewIndex
                           atIndexPath:(NSIndexPath *)indexPath;

// @optional

/**
 *  Default is NO.
 */
- (BOOL)shouldDeleteCellAfterMoveFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                                          atIndexPath:(NSIndexPath *)indexPath;

- (void)willDeleteCellFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                               atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Default is YES.
 */
- (BOOL)allowsMoveCellFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                               atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Default is the last row in last section.
 */
- (NSIndexPath *)indexPathToMoveForCellAtTableViewWithIndex:(NSInteger)destTableViewIndex;

/**
 *  Default is YES.
 */
- (BOOL)allowsMoveCellToTableViewAtIndex:(NSInteger)destTableViewIndex atIndexPath:(NSIndexPath *)indexPath;

- (void)didMoveCellToTableViewAtIndex:(NSInteger)destTableViewIndex atIndexPath:(NSIndexPath *)indexPath;

@end
