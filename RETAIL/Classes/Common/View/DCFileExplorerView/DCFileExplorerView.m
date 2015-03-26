//
//  DCFileExplorerView.m
//  DCFileExplorer
//
//  Created by Duke on 13-10-21.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCFileExplorerView.h"

#import "DCTableView.h"

#define kDefaultRowHeight 70.0

@interface DCFileExplorerView ()
<DCTableViewDataSource, DCTableViewDelegate>
{
  DCTableView *_tableView;
  
  NSInteger _numberOfFolders;
  NSInteger _numberOfFiles;
}

@end

@implementation DCFileExplorerView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _tableView = [[DCTableView alloc] initWithFrame:self.bounds];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = kDefaultRowHeight;
    [self addSubview:_tableView];
    
  }
  return self;
}

- (void)setRowHeight:(CGFloat)rowHeight {
  _rowHeight = rowHeight;
  _tableView.rowHeight = _rowHeight;
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
  return [_tableView dequeueReusableCellWithIdentifier:identifier];
}

- (void)reloadData {
  [_tableView reloadData];
}

- (void)reloadDataWithRowAnimation:(UITableViewRowAnimation)animation
{
  NSIndexSet *sections = [NSIndexSet indexSetWithIndex:0];
  [_tableView reloadSections:sections withRowAnimation:animation];
}

- (NSIndexPath *)indexPathOfFolderAtIndex:(NSInteger)index
{
  if (index == NSNotFound) {
    return nil;
  }
  
  return [NSIndexPath indexPathForRow:index inSection:0];
}

- (NSIndexPath *)indexPathOfFileAtIndex:(NSInteger)index
{
  if (index == NSNotFound) {
    return nil;
  }
  
  return [NSIndexPath indexPathForRow:index + _numberOfFolders inSection:0];
}

- (DCTableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return (DCTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
}

- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths
{
  [_tableView reloadRowsAtIndexPaths:indexPaths
                    withRowAnimation:UITableViewRowAnimationNone];
}

- (void)selectFileAtIndex:(NSInteger)index
                 animated:(BOOL)animated
           scrollPosition:(UITableViewScrollPosition)scrollPosition
{
  NSIndexPath *indexPath = [self indexPathOfFileAtIndex:index];
  [_tableView selectRowAtIndexPath:indexPath
                          animated:animated
                    scrollPosition:scrollPosition];
}

- (void)deselectFileAtIndex:(NSInteger)index
                   animated:(BOOL)animated
{
  NSIndexPath *indexPath = [self indexPathOfFileAtIndex:index];
  [_tableView deselectRowAtIndexPath:indexPath
                            animated:animated];
}

#pragma mark -
#pragma mark DCTableView DataSource & Delegate

- (NSInteger)tableView:(DCTableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
  _numberOfFolders = [_dataSource numberOfFoldersForFileExplorerView:self];
  _numberOfFiles = [_dataSource numberOfFilesForFileExplorerView:self];
  return _numberOfFolders + _numberOfFiles;
}

- (DCTableViewCell *)tableView:(DCTableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row < _numberOfFolders) {
    return [_dataSource fileExplorerView:self folderCellAtIndex:indexPath.row];
  }
  else {
    return [_dataSource fileExplorerView:self fileCellAtIndex:indexPath.row - _numberOfFolders];
  }
}

- (BOOL)tableView:(DCTableView *)tableView
    shouldSlideCellToLeftAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row < _numberOfFolders) {
    return NO;
  }
  else {
    return [_dataSource fileExplorerView:self
               shouldSlideFileCellToLeftAtIndex:indexPath.row - _numberOfFolders];
  }
}

- (BOOL)tableView:(DCTableView *)tableView
    shouldSlideCellToRightAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row < _numberOfFolders) {
    return NO;
  }
  else {
    return [_dataSource fileExplorerView:self
               shouldSlideFileCellToRightAtIndex:indexPath.row - _numberOfFolders];
  }
}

- (void)tableView:(DCTableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row < _numberOfFolders) {
    [self selectFolderAtIndex:indexPath.row];
  }
  else {
    [self selectFileAtIndex:indexPath.row - _numberOfFolders];
  }
}

#pragma mark -

- (void)selectFolderAtIndex:(NSInteger)index {
  if ([_delegate respondsToSelector:@selector(fileExplorerView:didSelectFolderAtIndex:)]) {
    [_delegate fileExplorerView:self didSelectFolderAtIndex:index];
  }
}

- (void)selectFileAtIndex:(NSInteger)index {
  if ([_delegate respondsToSelector:@selector(fileExplorerView:didSelectFileAtIndex:)]) {
    [_delegate fileExplorerView:self didSelectFileAtIndex:index];
  }
}

@end
