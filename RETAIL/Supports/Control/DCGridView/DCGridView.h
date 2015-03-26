//
//  DCGridView.h
//  DCGridView
//
//  Created by Duke Cui on 15/1/21.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCGridViewFooter.h"
#import "DCGridViewCell.h"

@protocol DCGridViewDataSource;
@protocol DCGridViewDelegate;

@interface DCGridView : UIView

@property (nonatomic,weak) id<DCGridViewDataSource> dataSource;
@property (nonatomic,weak) id<DCGridViewDelegate>   delegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)registerCellWithClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)reloadData;

- (DCGridViewCell *)dequeueReuseableCellWithIdentifier:(NSString *)reuseIdentifier
                                                forRow:(NSInteger)row
                                                column:(NSInteger)column;

@end


@protocol DCGridViewDataSource <NSObject>

@required
- (NSInteger)numberOfColumnsForGridView:(DCGridView *)gridView;
- (NSInteger)numberOfRowsForGridView:(DCGridView *)gridView;

- (DCGridViewCell *)gridView:(DCGridView *)gridView
                  cellForRow:(NSInteger)row
                      column:(NSInteger)column;

@optional
- (UIView *)gridView:(DCGridView *)gridView
    customHeaderView:(UIView *)header
           forColumn:(NSInteger)column;

- (DCGridViewFooter *)customFooterView:(DCGridViewFooter *)footer
                           forGridView:(DCGridView *)gridView;

@end

@protocol DCGridViewDelegate <NSObject>

@required
- (CGFloat)gridView:(DCGridView *)gridView widthForColumn:(NSInteger)column;
- (CGFloat)gridView:(DCGridView *)gridView heightForRow:(NSInteger)row;

@optional
- (BOOL)allowsShowHeaderForGridView:(DCGridView *)gridView;
- (CGFloat)heightForHeaderForGridView:(DCGridView *)gridView;

- (BOOL)allowsShowFooterForGridView:(DCGridView *)gridView;
- (CGFloat)heightForFooterForGridView:(DCGridView *)girdView;

@end
