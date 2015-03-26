//
//  DCMultiTableView.m
//  DCMultiTableView
//
//  Created by Duke on 13-10-30.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCMultiTableView.h"

#import "UITableView+DraggingCellAdditions.h"

#import "DCMultiTableView+DataSourceCaller.h"
#import "DCMultiTableView+DelegateCaller.h"

UIImage * SnapshotView(UIView *view)
{
  UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

#pragma mark -
#pragma mark Addition Categories

@interface UIGestureRecognizer (DCMultiTableViewAdditions)

- (void)cancel;

@end

@implementation UIGestureRecognizer (DCMultiTableViewAdditions)

- (void)cancel
{
  self.enabled = NO;
  self.enabled = YES;
}

@end

@interface UIView (DCMultiTableViewAdditions)

- (void)move:(CGPoint)offset;

@end

@implementation UIView (DCMultiTableViewAdditions)

- (void)move:(CGPoint)offset
{
  CGPoint center = self.center;
  center.x += offset.x;
  center.y += offset.y;
  self.center = center;
}

@end

#pragma mark -
#pragma mark DCMultiTableView

typedef UILongPressGestureRecognizer DragGestureRecognizer;

@interface DCMultiTableView ()
{
  NSMutableArray *_tableViews;
  
  UITableView *_srcTableView;
  NSInteger    _srcTableViewIndex;
  NSIndexPath *_srcIndexPath;
  
  UITableView *_destTableView;
  NSInteger    _destTableViewIndex;
  NSIndexPath *_destIndexPath;
  
  UIView      *_snapshot;
  
  BOOL _deleteCellAfterMove;
  
  CGPoint _lastLocation, _lastCenter;
}

- (void)setup;
- (void)reset;
- (void)handleDragGestureRecognizer:(DragGestureRecognizer *)dragGestureRecognizer;

- (UITableView *)tableViewAtLocation:(CGPoint)location;

- (void)dragCellUpAtLocation:(CGPoint)location;
- (void)moveDraggingCell:(CGPoint)location;
- (void)dropCell;

- (void)cancelMoving;
- (void)restoreDraggingCell;
- (void)destroyDraggingCell;

- (UIView *)snapshotForCell:(UITableViewCell *)cell;
- (void)moveCellToDestinationTableView;

- (BOOL)allowsBeginDragCellAtLocation:(CGPoint)location;
- (BOOL)allowsMoveCell;
- (void)willMoveCell;
- (BOOL)shouldDeleteCell;
- (void)willDeleteCell;
- (BOOL)allowsDropCellAtLocation:(CGPoint)location;
- (void)willDropCell;
- (void)didDropCell;
- (void)willRestoreCell;

@end

@implementation DCMultiTableView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setup];
  }
  return self;
}

- (void)didMoveToSuperview
{
  [super didMoveToSuperview];
  [self reloadData];
}

- (void)setup
{
  _tableViews = [NSMutableArray array];
  
  _srcTableViewIndex = _destTableViewIndex = NSNotFound;
  
  SEL dragAction = @selector(handleDragGestureRecognizer:);
  DragGestureRecognizer *d = [[DragGestureRecognizer alloc] initWithTarget:self action:dragAction];
  d.minimumPressDuration = 0.2;
  [self addGestureRecognizer:d];
}

- (void)reset
{
  _srcTableView        = nil;
  _srcTableViewIndex   = NSNotFound;
  _srcIndexPath        = nil;
  
  _destTableView       = nil;
  _destTableViewIndex  = NSNotFound;
  _destIndexPath       = nil;
  
  _snapshot            = nil;
  
  _deleteCellAfterMove = NO;
  
  _lastLocation        = CGPointZero;
  _lastCenter          = CGPointZero;
}

- (void)reloadData
{
  for (UITableView *tableview in _tableViews) {
    [tableview removeFromSuperview];
  }
  [_tableViews removeAllObjects];
  
  [self reset];
  
  NSInteger numberOfTableViews = [self numberOfTableViews];
  for (int i = 0; i < numberOfTableViews; i++) {
    CGRect frame          = [self frameForTableViewAtIndex:i];
    Class  tableViewClass = [self registerTableViewClassAtIndex:i];
    
    UITableView *tableView = [[tableViewClass alloc] initWithFrame:frame];
    [_tableViews addObject:tableView];
    
    tableView.dataSource = [self dataSourceForTableViewAtIndex:i];
    tableView.delegate   = [self delegateForTableViewAtIndex:i];
    [self addSubview:tableView];
    
    tableView = [self customizeTableView:tableView];
    
  }
}

- (void)handleDragGestureRecognizer:(DragGestureRecognizer *)dragGestureRecognizer
{
  CGPoint location = [dragGestureRecognizer locationInView:self];
  
  switch (dragGestureRecognizer.state) {
    case UIGestureRecognizerStateBegan:
    {
      if ([self allowsBeginDragCellAtLocation:location]) {
        [self dragCellUpAtLocation:location];
      }
      else {
        [dragGestureRecognizer cancel];
      }
      break;
    }
    case UIGestureRecognizerStateChanged:
    {
      [self moveDraggingCell:location];
      break;
    }
    case UIGestureRecognizerStateEnded:
    {
      if ([self allowsDropCellAtLocation:location]) {
        [self dropCell];
      }
      else {
        [self cancelMoving];
        [self reset];
      }
      break;
    }
    default:
    {
      [self reset];
      break;
    }
  }
  
  _lastLocation = location;
  _lastCenter   = _snapshot.center;
}

- (UITableView *)tableViewAtIndex:(NSInteger)index
{
  return _tableViews[index];
}

- (NSInteger)indexOfTableView:(UITableView *)tableView
{
  return [_tableViews indexOfObject:tableView];
}

- (UITableView *)tableViewAtLocation:(CGPoint)location
{
  UITableView *tableViewAtLocation = nil;
  
  for (UITableView *tableView in _tableViews) {
    if (CGRectContainsPoint(tableView.frame, location)) {
      tableViewAtLocation = tableView;
      break;
    }
  }
  
  return tableViewAtLocation;
}

- (void)dragCellUpAtLocation:(CGPoint)location
{
  [self willMoveCell];
  
  UITableViewCell *cell = [_srcTableView cellForRowAtIndexPath:_srcIndexPath];
  cell.selected    = NO;
  cell.highlighted = NO;
  
  _snapshot = [self snapshotForCell:cell];
  [self addSubview:_snapshot];
  
  _deleteCellAfterMove = [self shouldDeleteCell];
  
  if (_deleteCellAfterMove) {
    [self willDeleteCell]; 
    
    [_srcTableView deleteRowsAtIndexPaths:@[_srcIndexPath]
                         withRowAnimation:UITableViewRowAnimationTop];
  }
}

- (UIView *)snapshotForCell:(UITableViewCell *)cell
{
  CGRect cellFrame = [self convertRect:cell.frame fromView:_srcTableView];
  
  UIImageView *snapshot = [[UIImageView alloc] initWithImage:SnapshotView(cell)];
  snapshot.frame = cellFrame;
  snapshot.layer.shadowOpacity = 0.7;
  snapshot.layer.shadowRadius  = 3;
  snapshot.layer.shadowOffset  = CGSizeZero;
  
  return snapshot;
}

- (void)moveDraggingCell:(CGPoint)location
{
  CGFloat x = location.x - _lastLocation.x;
  CGFloat y = location.y - _lastLocation.y;
  [_snapshot move:CGPointMake(x, y)];
}

- (void)dropCell
{
  [self moveCellToDestinationTableView];
}

- (void)cancelMoving
{
  if (_deleteCellAfterMove) {
    [self restoreDraggingCell];
  }
  else {
    [self destroyDraggingCell];
  }
}

- (void)restoreDraggingCell
{
  [self willRestoreCell];
  
  [_srcTableView restoreCellAtIndexPath:_srcIndexPath cellSnapshot:_snapshot];
}

- (void)destroyDraggingCell
{
  [UIView animateWithDuration:0.2 animations:^{
    _snapshot.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    _snapshot.alpha     = 0.0;
  } completion:^(BOOL finished) {
    [_snapshot removeFromSuperview];
    _snapshot = nil;
  }];
}

- (void)moveCellToDestinationTableView
{
  [self willDropCell];
  
  [_destTableView addCellToIndexPath:_destIndexPath cellSnapshot:_snapshot];
  
  [self didDropCell];
}

#pragma mark -

- (BOOL)allowsBeginDragCellAtLocation:(CGPoint)location
{
  _srcTableView = [self tableViewAtLocation:location];
  
  if (_srcTableView == nil) {
    return NO;
  }
  
  _srcTableViewIndex = [self indexOfTableView:_srcTableView];
  
  CGPoint locationInTableView = [self convertPoint:location toView:_srcTableView];
  _srcIndexPath = [_srcTableView indexPathForRowAtPoint:locationInTableView];
  
  if (_srcIndexPath == nil) {
    return NO;
  }
  
  if (![self allowsMoveCell]) {
    return NO;
  }
  
  return YES;
}

- (BOOL)allowsMoveCell
{
  return [self allowsMoveCellFromTableViewAtIndex:_srcTableViewIndex atIndexPath:_srcIndexPath];
}

- (void)willMoveCell
{
  [self willMoveCellFromTableViewAtIndex:_srcTableViewIndex atIndexPath:_srcIndexPath];
}

- (BOOL)shouldDeleteCell
{
  return [self shouldDeleteCellAfterMoveFromTableViewAtIndex:_srcTableViewIndex
                                                 atIndexPath:_srcIndexPath];
}

- (void)willDeleteCell
{
  [self willDeleteCellFromTableViewAtIndex:_srcTableViewIndex atIndexPath:_srcIndexPath];
}

- (BOOL)allowsDropCellAtLocation:(CGPoint)location
{
  _destTableView = [self tableViewAtLocation:location];
  
  if (_destTableView == nil) {
    return NO;
  }
  
  _destTableViewIndex = [self indexOfTableView:_destTableView];
  
  if (_destTableView == _srcTableView) {
    return NO;
  }
  else {
    _destIndexPath  = [self indexPathToMoveForCellAtTableViewWithIndex:_destTableViewIndex];
    
    if (![self allowsMoveCellToTableViewAtIndex:_destTableViewIndex atIndexPath:_destIndexPath])
    {
      return NO;
    }
  }
  
  return YES;
}

- (void)willDropCell
{
  [self willMoveCellToTableViewAtIndex:_destTableViewIndex atIndexPath:_destIndexPath];
}

- (void)didDropCell
{
  [self didMoveCellToTableViewAtIndex:_destTableViewIndex atIndexPath:_destIndexPath];
}

- (void)willRestoreCell
{
  [self willRestoreCellToTableViewAtIndex:_srcTableViewIndex atIndexPath:_srcIndexPath];
}

@end
