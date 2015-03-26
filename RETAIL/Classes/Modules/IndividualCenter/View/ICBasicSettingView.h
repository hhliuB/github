//
//  ICBasicSettingView.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCView.h"

@interface ICBasicSettingView : DCView

@property (nonatomic,readonly) UILabel *playDefinitionLabel;
@property (nonatomic,readonly) UILabel *cacheDefinitionLable;

@property (nonatomic,readonly) UITableView *playDefinitionTableView;
@property (nonatomic,readonly) UITableView *cacheDefinitionTableView;

@property (nonatomic,readonly) UISwitch *skipCreditsSwitch;
@property (nonatomic,readonly) UISwitch *automaticSeriesSwich;
@property (nonatomic,readonly) UISwitch *cacheToneSwich;
@property (nonatomic,readonly) UISwitch *allow3GSwich;


@end
