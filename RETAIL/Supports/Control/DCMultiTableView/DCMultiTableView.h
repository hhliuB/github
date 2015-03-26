//
//  DCMultiTableView.h
//  DCMultiTableView
//
//  Created by Duke on 13-10-30.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCMultiTableViewDataSource;
@protocol DCMultiTableViewDelegate;

@interface DCMultiTableView : UIView

@property (nonatomic,weak) id<DCMultiTableViewDataSource> dataSource;
@property (nonatomic,weak) id<DCMultiTableViewDelegate>   delegate;

- (void)reloadData;
- (UITableView *)tableViewAtIndex:(NSInteger)index;
- (NSInteger)indexOfTableView:(UITableView *)tableView;

@end

@protocol DCMultiTableViewDataSource <NSObject>

@required
- (NSInteger)numberOfTableViewsForMultiTableView:(DCMultiTableView *)multiTableView;
- (CGRect)multiTableView:(DCMultiTableView *)multiTableView
    frameForTableViewAtIndex:(NSInteger)index;

- (id<UITableViewDataSource>)multiTableView:(DCMultiTableView *)multiTableView
              dataSourceForTableViewAtIndex:(NSInteger)index;
- (id<UITableViewDelegate>)multiTableView:(DCMultiTableView *)multiTableView
              delegateForTableViewAtIndex:(NSInteger)index;

@optional
/**
 *  Default is UITableView if not implemented.
 */
- (Class)multiTableView:(DCMultiTableView *)multiTableView
    registerTableViewClassAtIndex:(NSInteger)index;

- (UITableView *)multiTableView:(DCMultiTableView *)multiTableView
             customizeTableView:(UITableView *)tableView;

@end


@protocol DCMultiTableViewDelegate <NSObject>

@required

- (void)multiTableView:(DCMultiTableView *)multiTableView
    willMoveCellFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                         atIndexPath:(NSIndexPath *)indexPath;

- (void)multiTableView:(DCMultiTableView *)multiTableView
    willRestoreCellToTableViewAtIndex:(NSInteger)tableViewIndex
                          atIndexPath:(NSIndexPath *)indexPath;

- (void)multiTableView:(DCMultiTableView *)multiTableView
    willMoveCellToTableViewAtIndex:(NSInteger)destTableViewIndex
                       atIndexPath:(NSIndexPath *)indexPath;

@optional

- (BOOL)multiTableView:(DCMultiTableView *)multiTableView
    shouldDeleteCellAfterMoveFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                                      atIndexPath:(NSIndexPath *)indexPath;

- (void)multiTableView:(DCMultiTableView *)multiTableView
    willDeleteCellFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                           atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Default is YES if not implemented.
 */
- (BOOL)multiTableView:(DCMultiTableView *)multiTableView
    allowsMoveCellFromTableViewAtIndex:(NSInteger)srcTableViewIndex
                           atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Default is the last row in last section if not implemented or return 'nil'.
 */
- (NSIndexPath *)multiTableView:(DCMultiTableView *)multiTableView
    indexPathToMoveForCellAtTableViewWithIndex:(NSInteger)destTableViewIndex;

/**
 *  Default is YES if not implemented.
 */
- (BOOL)multiTableView:(DCMultiTableView *)multiTableView
    allowsMoveCellToTableViewAtIndex:(NSInteger)destTableViewIndex
                         atIndexPath:(NSIndexPath *)indexPath;

- (void)multiTableView:(DCMultiTableView *)multiTableView
    didMoveCellToTableViewAtIndex:(NSInteger)destTableViewIndex
                      atIndexPath:(NSIndexPath *)indexPath;

@end

