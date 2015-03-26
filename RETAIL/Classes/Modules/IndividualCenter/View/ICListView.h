//
//  ICListView.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCView.h"

@interface ICListView : DCView

@property (nonatomic,readonly) UIImageView *iconView;
@property (nonatomic,readonly) UIImageView *iconBorderView;

@property (nonatomic,readonly) UILabel     *titleLabel;
@property (nonatomic,readonly) UITableView *tableView;

@end
