//
//  DCGridView+ProtocolShortcuts.m
//  DCGridView
//
//  Created by Duke Cui on 15/1/21.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCGridView+ProtocolShortcuts.h"

@implementation DCGridView (ProtocolShortcuts)

#pragma mark -
#pragma mark Data Source

#pragma mark Required
- (NSInteger)numberOfColumns
{
  return [self.dataSource numberOfColumnsForGridView:self];
}

- (NSInteger)numberOfRows
{
  return [self.dataSource numberOfRowsForGridView:self];
}

- (DCGridViewCell *)cellForRow:(NSInteger)row column:(NSInteger)column
{
  return [self.dataSource gridView:self cellForRow:row column:column];
}

#pragma mark Optional

- (UIView *)customHeaderView:(UIView *)header forColumn:(NSInteger)column
{
  if ([self.dataSource respondsToSelector:@selector(gridView:customHeaderView:forColumn:)]) {
    return [self.dataSource gridView:self customHeaderView:header forColumn:column];
  }
  
  return header;
}

- (DCGridViewFooter *)customFooterView:(DCGridViewFooter *)footer
{
  if ([self.dataSource respondsToSelector:@selector(customFooterView:forGridView:)]) {
    return [self.dataSource customFooterView:footer forGridView:self];
  }
  
  return footer;
}

#pragma mark -
#pragma mark Delegate

#pragma mark Required
- (CGFloat)widthForColumn:(NSInteger)column
{
  
  return [self.delegate gridView:self widthForColumn:column];
}

- (CGFloat)heightForRow:(NSInteger)row
{
  return [self.delegate gridView:self heightForRow:row];
}

#pragma mark Optional

- (BOOL)allowsShowHeader
{
  if ([self.delegate respondsToSelector:@selector(allowsShowHeaderForGridView:)]) {
    return [self.delegate allowsShowHeaderForGridView:self];
  }
  
  return NO;
}

- (CGFloat)heightForHeader
{
  if ([self.delegate respondsToSelector:@selector(heightForHeaderForGridView:)]) {
    return [self.delegate heightForHeaderForGridView:self];
  }
  
  return 0;
}

- (BOOL)allowsShowFooter
{
  if ([self.delegate respondsToSelector:@selector(allowsShowFooterForGridView:)]) {
    return [self.delegate allowsShowFooterForGridView:self];
  }
  
  return NO;
}

- (CGFloat)heightForFooter
{
  if ([self.delegate respondsToSelector:@selector(heightForFooterForGridView:)]) {
    return [self.delegate heightForFooterForGridView:self];
  }
  
  return 0;
}

@end
