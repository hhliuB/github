//
//  UITableView+DraggingCellAdditions.h
//  DCMultiTableView
//
//  Created by Duke on 13-11-8.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DraggingCellAdditions)

- (void)addCellToIndexPath:(NSIndexPath *)indexPath cellSnapshot:(UIView *)snapshot;
- (void)restoreCellAtIndexPath:(NSIndexPath *)indexPath cellSnapshot:(UIView *)snapshot;

@end
