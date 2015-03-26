//
//  DCMultiTableView+DataSourceCaller.h
//  DCMultiTableView
//
//  Created by Duke on 13-11-8.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCMultiTableView.h"

@interface DCMultiTableView (DataSourceCaller)

// @required
- (NSInteger)numberOfTableViews;
- (CGRect)frameForTableViewAtIndex:(NSInteger)index;

- (id<UITableViewDataSource>)dataSourceForTableViewAtIndex:(NSInteger)index;
- (id<UITableViewDelegate>)delegateForTableViewAtIndex:(NSInteger)index;

// @optional
- (Class)registerTableViewClassAtIndex:(NSInteger)index;

- (UITableView *)customizeTableView:(UITableView *)tableView;

@end
