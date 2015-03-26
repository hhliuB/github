//
//  HPBottomView.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/18.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCView.h"

@class HPBottomView;

@protocol HPBottomViewDelegate <NSObject>

@required

- (NSInteger)numberOfscrollerViewInBottomtView;
- (UITableView *)bottomView:(HPBottomView *)bottomView  greatScrollerViewInBottomView:(NSInteger)index;

@optional

- (CGFloat)bottomView:(HPBottomView *)bottomView  heightForHeaderInIndex:(NSInteger)index;
- (UIView *)bottomView:(HPBottomView *)bottomView  headerOfScrollerViewInIndex:(NSInteger)index;

@end

@interface HPBottomView : DCView

@property (nonatomic,weak) id<HPBottomViewDelegate> delegate;

@property (nonatomic,assign) NSInteger scrollerHeight;
@property (nonatomic,assign) NSInteger numberOfTag;

- (void)reloadData;
@end
