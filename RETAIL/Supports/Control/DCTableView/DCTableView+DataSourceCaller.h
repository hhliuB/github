//
//  DCTableView+DataSourceCaller.h
//  DCTableView
//
//  Created by Duke on 13-9-13.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCTableView.h"

@interface DCTableView (DataSourceCaller)

- (DCTableViewCell *)createCellAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)shouldSlideToLeftAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)shouldSlideToRightAtIndexPath:(NSIndexPath *)indexPath;

@end
