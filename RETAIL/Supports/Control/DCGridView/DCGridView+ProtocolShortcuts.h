//
//  DCGridView+ProtocolShortcuts.h
//  DCGridView
//
//  Created by Duke Cui on 15/1/21.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCGridView.h"

@interface DCGridView (ProtocolShortcuts)

#pragma mark -
#pragma mark DataSource

#pragma mark Required
- (NSInteger)numberOfColumns;
- (NSInteger)numberOfRows;

- (DCGridViewCell *)cellForRow:(NSInteger)row column:(NSInteger)column;

#pragma mark Optional

- (UIView *)customHeaderView:(UIView *)header forColumn:(NSInteger)column;
- (DCGridViewFooter *)customFooterView:(DCGridViewFooter *)footer;

#pragma mark -
#pragma mark Delegate

#pragma mark Required
- (CGFloat)widthForColumn:(NSInteger)column;
- (CGFloat)heightForRow:(NSInteger)row;

#pragma mark Optional

- (BOOL)allowsShowHeader;
- (CGFloat)heightForHeader;

- (BOOL)allowsShowFooter;
- (CGFloat)heightForFooter;


@end
