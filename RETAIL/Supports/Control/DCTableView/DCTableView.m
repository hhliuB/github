//
//  DCTableView.m
//  DCTableView
//
//  Created by Duke on 13-9-12.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCTableView.h"

#import "DCTableViewCell.h"

#import "DCTableView+DataSourceCaller.h"

#import "DCTableViewProxy.h"

@interface DCTableView ()
<DCTableViewCellDelegate>

@property (nonatomic,strong) DCTableViewProxy *proxy;
@property (nonatomic,assign) BOOL cellDragging;

@end

@implementation DCTableView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self) {
    _proxy = [[DCTableViewProxy alloc] init];
    _proxy.middleMan = self;
    [super setDelegate:(id)_proxy];
    [super setDataSource:(id)_proxy];
  }
  
  return self;
}

- (void)setDataSource:(id<DCTableViewDataSource>)dataSource
{
  [super setDataSource:nil];
  [self.proxy setDataSource:dataSource];
  [super setDataSource:(id)self.proxy];
}

- (id<DCTableViewDataSource>)dataSource
{
  return self.proxy.dataSource;
}

- (void)setDelegate:(id<DCTableViewDelegate>)delegate
{
  [super setDelegate:nil];
  [self.proxy setDelegate:delegate];
  [super setDelegate:(id)self.proxy];
}

- (id<DCTableViewDelegate>)delegate
{
  return self.proxy.delegate;
}

#pragma mark -
#pragma mark UITableView DataSource

/*
 
 以下方法可被 DCTableViewProxy 转发
 
 UITableViewDataSource
 
 * tableView:cellForRowAtIndexPath:
 * tableView:numberOfRowsInSection:
 * numberOfSectionsInTableView:
 * tableView:titleForHeaderInSection:
 * tableView:titleForFooterInSection:
 * sectionIndexTitlesForTableView:
 * tableView:sectionForSectionIndexTitle:atIndex:
 
 
 UITableViewDelegate
 
 * tableView:commitEditingStyle:forRowAtIndexPath:
 * tableView:moveRowAtIndexPath:toIndexPath:
 * tableView:canEditRowAtIndexPath:
 * tableView:canMoveRowAtIndexPath:
 * tableView:shouldShowMenuForRowAtIndexPath:
 * tableView:canPerformAction:forRowAtIndexPath:withSender:
 * tableView:performAction:forRowAtIndexPath:withSender:
 
 */

- (DCTableViewCell *)tableView:(DCTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  DCTableViewCell *cell = [self createCellAtIndexPath:indexPath];
  cell.delegate = self;
  return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  for (DCTableViewCell *c in [self visibleCells]) {
    [c closeAnimated:YES];
  }
  self.cellDragging = NO;
}

#pragma mark -
#pragma mark DCTableViewCell Delegate

- (BOOL)cellShouldBeginDragging:(DCTableViewCell *)cell
{
  if(!self.cellDragging) {
    self.cellDragging = YES;
    return YES;
  }
  return NO;
}

- (void)cellDidBeginDragging:(DCTableViewCell *)cell
{
  NSIndexPath *indexPath = [self indexPathForCell:cell];
  cell.allowsSlideToLeft = [self shouldSlideToLeftAtIndexPath:indexPath];
  cell.allowsSlideToRight = [self shouldSlideToRightAtIndexPath:indexPath];
  
  NSArray *visibleCells = [self visibleCells];
  for (DCTableViewCell *c in visibleCells) {
    if (c != cell) {
      [c closeAnimated:YES];
    }
  }
}

- (void)cellDidEndDragging:(DCTableViewCell *)cell
{
  self.cellDragging = NO;
}

- (void)cellDidAbortDragging:(DCTableViewCell *)cell
{
  self.cellDragging = NO;
}

- (void)cell:(DCTableViewCell *)cell actionButtonDidPress:(UIButton *)button
{
  NSIndexPath *indexPath = [self indexPathForCell:cell];
  
  if ([self.delegate respondsToSelector:@selector(tableView:didPressActionButton:atIndexPath:)]) {
    [self.delegate tableView:self didPressActionButton:button atIndexPath:indexPath];
  }
}

@end
