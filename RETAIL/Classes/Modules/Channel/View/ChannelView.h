//
//  ChannelView.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/19.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCView.h"

#import "HPHeaderView.h"

@interface ChannelView : DCView

@property (nonatomic,strong) HPHeaderView     *headerView;
@property (nonatomic,strong) UITableView      *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;

@end
