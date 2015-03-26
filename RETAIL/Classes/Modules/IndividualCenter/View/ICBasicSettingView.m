//
//  ICBasicSettingView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICBasicSettingView.h"

#import <CoreData/CoreData.h>

// 基本设置

@interface ICBasicSettingView()

@property (nonatomic,strong) UILabel *playDefinitionLeftLabel;
@property (nonatomic,strong) UILabel *cacheDefinitionLeftLable;

@property (nonatomic,strong) UILabel *skipCreditsLabel;
@property (nonatomic,strong) UILabel *automaticSeriesLabel;
@property (nonatomic,strong) UILabel *cacheToneLabel;
@property (nonatomic,strong) UILabel *allow3GLabel;

@end

@implementation ICBasicSettingView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat x = 30;
    CGFloat y = 30;
    CGFloat width = self.width - 60;
    CGFloat height = 50;
    CGFloat cornerRadiue = 10;
    CGFloat tableViewHeight = 120;
    CGFloat rowHeight = 40;
    
    UIView *playDefinitionView = [self addViewWithFrame:CGRectMake(x, y, width, height + tableViewHeight) class:[UIView class] backgroundColor:kWhiteColor];
    playDefinitionView.layer.cornerRadius = cornerRadiue;
    
     _playDefinitionLeftLabel = [playDefinitionView addLabelWithFrame:CGRectMake(20, 0, 200, height) text:@"播放清晰度" textColor:kTextColor font:kLargerFont];
    _playDefinitionLabel = [playDefinitionView addLabelWithFrame:CGRectMake(width - 60, 0, 60, height) text:@"高清" textColor:kTextColor font:kLargerFont];
    
    _playDefinitionTableView = [playDefinitionView addViewWithFrame:CGRectMake(20, 49, width - 40, tableViewHeight) class:[UITableView class] backgroundColor:kLightBlueColor];
    _playDefinitionTableView.rowHeight = rowHeight;
    _playDefinitionTableView.scrollEnabled = NO;
    y += tableViewHeight + 10 + height;
    
    UIView *cacheDefinitionView = [self addViewWithFrame:CGRectMake(x, y, width, height + tableViewHeight) class:[UIView class] backgroundColor:kWhiteColor];
    cacheDefinitionView.layer.cornerRadius = cornerRadiue;
    _cacheDefinitionLeftLable = [cacheDefinitionView addLabelWithFrame:CGRectMake(20, 0, 200, height) text:@"缓存清晰度" textColor:kTextColor font:kLargerFont];
    _cacheDefinitionLable = [cacheDefinitionView addLabelWithFrame:CGRectMake(width - 60, 0, 60, height) text:@"高清" textColor:kTextColor font:kLargerFont];
    
    _cacheDefinitionTableView = [cacheDefinitionView addViewWithFrame:CGRectMake(20, 49, width - 40, tableViewHeight) class:[UITableView class] backgroundColor:kLightBlueColor];
    _cacheDefinitionTableView.rowHeight = rowHeight;
    _cacheDefinitionTableView.scrollEnabled = NO;
    y += tableViewHeight + 10 + height;
    
    UIView *skipCreditsView = [self addViewWithFrame:CGRectMake(x, y, width, height) class:[UIView class] backgroundColor:kWhiteColor];
    skipCreditsView.layer.cornerRadius = cornerRadiue;
    _skipCreditsLabel = [skipCreditsView addLabelWithFrame:CGRectMake(20, 0, 200, height) text:@"跳过片头片尾" textColor:kTextColor font:kLargerFont];
    _skipCreditsSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(width - 80, 10, 50, 30)];
    _skipCreditsSwitch.on = YES;
    [skipCreditsView addSubview:_skipCreditsSwitch];
    y += height + 10;
    
    UIView *automaticSeriesView = [self addViewWithFrame:CGRectMake(x, y, width, height) class:[UIView class] backgroundColor:kWhiteColor];
    automaticSeriesView.layer.cornerRadius = cornerRadiue;
    _automaticSeriesLabel = [automaticSeriesView addLabelWithFrame:CGRectMake(20, 0, 200, height) text:@"自动连播" textColor:kTextColor font:kLargerFont];
    _automaticSeriesSwich = [[UISwitch alloc]initWithFrame:CGRectMake(width - 80, 10, 50, 30)];
    [automaticSeriesView addSubview:_automaticSeriesSwich];
    y += height + 10;
    
    UIView *cacheToneView = [self addViewWithFrame:CGRectMake(x, y, width, height) class:[UIView class] backgroundColor:kWhiteColor];
    cacheToneView.layer.cornerRadius = cornerRadiue;
    _cacheToneLabel = [cacheToneView addLabelWithFrame:CGRectMake(20, 0, 200, height) text:@"缓存完成提示音" textColor:kTextColor font:kLargerFont];

    _cacheToneSwich = [[UISwitch alloc]initWithFrame:CGRectMake(width - 80, 10, 50, 30)];
    [cacheToneView addSubview:_cacheToneSwich];
    y += height + 10;
    
    UIView *allow3GView = [self addViewWithFrame:CGRectMake(x, y, width, height) class:[UIView class] backgroundColor:kWhiteColor];
    allow3GView.layer.cornerRadius = cornerRadiue;
    _allow3GLabel = [allow3GView addLabelWithFrame:CGRectMake(20, 0, 200, height) text:@"允许3G下缓存视频" textColor:kTextColor font:kLargerFont];
    
    _allow3GSwich = [[UISwitch alloc]initWithFrame:CGRectMake(width - 80, 10, 50, 30)];
    [allow3GView addSubview:_allow3GSwich];
    
  }
  return self;
}

@end
