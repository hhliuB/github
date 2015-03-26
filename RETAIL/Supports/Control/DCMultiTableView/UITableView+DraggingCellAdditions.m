//
//  UITableView+DraggingCellAdditions.m
//  DCMultiTableView
//
//  Created by Duke on 13-11-8.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "UITableView+DraggingCellAdditions.h"

@implementation UITableView (DraggingCellAdditions)

- (void)addCellToIndexPath:(NSIndexPath *)indexPath cellSnapshot:(UIView *)snapshot
{
  [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
  
  CGPoint offset = self.contentOffset;
  
  [self scrollToRowAtIndexPath:indexPath
              atScrollPosition:UITableViewScrollPositionBottom
                      animated:NO];
  
  UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
  cell.contentView.hidden = YES;
  
  CGRect frame = [self convertRect:cell.frame toView:self.superview];
  
  frame.origin.y = CGRectGetMinY(frame) + (CGRectGetHeight(frame) - CGRectGetHeight(snapshot.bounds)) / 2;
  frame.size = snapshot.bounds.size;
  
  self.contentOffset = offset;
  
  [self scrollToRowAtIndexPath:indexPath
              atScrollPosition:UITableViewScrollPositionBottom
                      animated:YES];
  
  [UIView animateWithDuration:0.4 animations:^{
    snapshot.frame = frame;
  } completion:^(BOOL finished) {
    cell.contentView.hidden = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
      snapshot.alpha = 0.0;
    } completion:^(BOOL finished) {
      [snapshot removeFromSuperview];
    }];
  }];
}

- (void)restoreCellAtIndexPath:(NSIndexPath *)indexPath cellSnapshot:(UIView *)snapshot
{
  [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
  
  UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
  cell.contentView.hidden = YES;
  
  CGRect frame = [self convertRect:cell.frame toView:self.superview];
  
  [UIView animateWithDuration:0.2 animations:^{
    snapshot.frame = frame;
  } completion:^(BOOL finished) {
    cell.contentView.hidden = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
      snapshot.alpha = 0.0;
    } completion:^(BOOL finished) {
      [snapshot removeFromSuperview];
    }];
  }];
}

@end
