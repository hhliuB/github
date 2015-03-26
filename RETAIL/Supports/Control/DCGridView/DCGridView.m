//
//  DCGridView.m
//  DCGridView
//
//  Created by Duke Cui on 15/1/21.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCGridView.h"
#import "DCGridViewHeader.h"
#import "DCGridViewFooter.h"
#import "DCGridViewCell.h"

#import "DCGridView+ProtocolShortcuts.h"

#define kHeaderReuseIdentifier @"kDCGridViewHeaderReuseIdentifier"
#define kFooterReuseIdentifier @"kDCGridViewFooterReuseIdentifier"

@interface DCGridView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
  NSMutableDictionary        *_reusePool;
  UICollectionView           *_collectionView;
  UICollectionViewFlowLayout *_flowLayout;
  
  NSInteger _numberOfRows;
  NSInteger _numberOfColumns;
  
  NSMutableArray *_heightForRows;
  NSMutableArray *_widthForColumns;
  
  CGFloat _heightForHeader;
  CGFloat _heightForFooter;
}

@end

@implementation DCGridView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self) {
    _reusePool       = [NSMutableDictionary dictionary];
    _heightForRows   = [NSMutableArray array];
    _widthForColumns = [NSMutableArray array];
  }
  
  return self;
}

- (void)didMoveToSuperview
{
  [super didMoveToSuperview];
  [self reloadData];
}

- (void)registerCellWithClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)reuseIdentifier
{
  _reusePool[reuseIdentifier] = cellClass;
}

- (void)reloadData
{
  [self setup];
  
  if (_numberOfRows > 0 && _numberOfColumns > 0) {
    [self.collectionView reloadData];
  }
}

- (void)setup
{
  _numberOfColumns = [self numberOfColumns];
  _numberOfRows    = [self numberOfRows];
 
  if (_numberOfColumns == 0 && _numberOfRows == 0) {
    return;
  }
  
  _heightForHeader = 0;
  _heightForFooter = 0;
  
  [_heightForRows   removeAllObjects];
  [_widthForColumns removeAllObjects];
 
  CGFloat totalHeight = 0;
  for (int i = 0; i < _numberOfRows; i++) {
    CGFloat h = [self heightForRow:i];
    totalHeight += h;
    
    [_heightForRows addObject:@(h)];
  }
  
  CGFloat totalWidth = 0;
  for (int i = 0; i < _numberOfColumns; i++) {
    CGFloat w = [self widthForColumn:i];
    totalWidth += w;
    
    [_widthForColumns addObject:@(w)];
  }
  
  CGFloat gridViewWidth = CGRectGetWidth(self.bounds);
  NSAssert(totalWidth <= gridViewWidth,
           @"Width for columns (%g) is greater than DCGridView width (%g).",
           totalWidth, gridViewWidth);
  
  CGFloat minimumInteritemSpacing = 0;
  if (_numberOfColumns > 1) {
    minimumInteritemSpacing = (gridViewWidth - totalWidth) / (_numberOfColumns - 1);
  }
  
  _flowLayout = [[UICollectionViewFlowLayout alloc] init];
  _flowLayout.minimumLineSpacing      = 0;
  _flowLayout.minimumInteritemSpacing = minimumInteritemSpacing;
  
  _collectionView.collectionViewLayout = _flowLayout;
  
  if ([self allowsShowHeader]) {
    [self.collectionView registerClass:[DCGridViewHeader class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:kHeaderReuseIdentifier];
    _heightForHeader = [self heightForHeader];
  }
  
  if ([self allowsShowFooter]) {
    [_collectionView registerClass:[DCGridViewFooter class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:kFooterReuseIdentifier];
    _heightForFooter = [self heightForFooter];
  }
}

- (DCGridViewCell *)dequeueReuseableCellWithIdentifier:(NSString *)reuseIdentifier
                                                forRow:(NSInteger)row
                                                column:(NSInteger)column
{
  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row * _numberOfColumns + column
                                               inSection:0];
  return [_collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                    forIndexPath:indexPath];
}

#pragma mark -
#pragma mark Properties

- (UICollectionView *)collectionView
{
  if (!_collectionView) {    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                         collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor              = [UIColor clearColor];
    _collectionView.dataSource                   = self;
    _collectionView.delegate                     = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_collectionView];
    
    [_reusePool enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      [_collectionView registerClass:obj forCellWithReuseIdentifier:key];
    }];
  }
  
  return _collectionView;
}

#pragma mark -
#pragma mark UICollectionView DataSource & Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section
{
  CGFloat width = CGRectGetWidth(self.bounds);
  CGFloat height = _heightForHeader;
  return CGSizeMake(width, height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
    referenceSizeForFooterInSection:(NSInteger)section
{
  CGFloat width = CGRectGetWidth(self.bounds);
  CGFloat height = _heightForFooter;
  return CGSizeMake(width, height);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    return [self collectionView:collectionView headerAtIndexPath:indexPath];
  }
  else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
    return [self collectionView:collectionView footerAtIndexPath:indexPath];
  }
  
  return nil;
}

- (DCGridViewHeader *)collectionView:(UICollectionView *)collectionView
                   headerAtIndexPath:(NSIndexPath *)indexPath
{
  DCGridViewHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                withReuseIdentifier:kHeaderReuseIdentifier
                                                                       forIndexPath:indexPath];
  
  CGFloat interItemSpacing = _flowLayout.minimumInteritemSpacing;
  
  __block CGFloat x = 0;
  __block CGFloat w = 0;
          CGFloat h = _heightForHeader;
  
  [_widthForColumns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (idx > 0) {
      x += w + interItemSpacing;
    }
    
    w = [obj floatValue];
    
    UIView *columnHeader            = [[UIView alloc] initWithFrame:CGRectMake(x, 0, w, h)];
    UIView *columnHeaderContentView = [[UIView alloc] initWithFrame:columnHeader.bounds];

    columnHeaderContentView = [self customHeaderView:columnHeaderContentView forColumn:idx];
    
    [columnHeader addSubview:columnHeaderContentView];
    [header       addSubview:columnHeader];
  }];
  
  return header;
}

- (DCGridViewFooter *)collectionView:(UICollectionView *)collectionView
                   footerAtIndexPath:(NSIndexPath *)indexPath
{
  DCGridViewFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                withReuseIdentifier:kFooterReuseIdentifier
                                                                       forIndexPath:indexPath];
  footer = [self customFooterView:footer];
  return footer;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger row    = indexPath.item / _numberOfColumns;
  NSInteger column = indexPath.item % _numberOfColumns;
  
  CGFloat width  = [_widthForColumns[column] floatValue];
  CGFloat height = [_heightForRows[row]      floatValue];
  
  return CGSizeMake(width, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
  return _numberOfColumns * _numberOfRows;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger row    = indexPath.item / _numberOfColumns;
  NSInteger column = indexPath.item % _numberOfColumns;
  
  return [self cellForRow:row column:column];
}

@end
