//
//  ICDetailView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICDetailView.h"

@implementation ICDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _basicInformationView = [self addViewWithFrame:self.bounds class:[ICBasicInformationView class] backgroundColor:kClearColor];
    _basicSettingView = [self addViewWithFrame:self.bounds class:[ICBasicSettingView class] backgroundColor:kLightGrayColor];
    _collectionProgramView = [self addViewWithFrame:self.bounds class:[ICCollectionProgramView class] backgroundColor:kClearColor];
    _fansListView = [self addViewWithFrame:self.bounds class:[ICFansListView class] backgroundColor:kClearColor];
    _offineCacheView = [self addViewWithFrame:self.bounds class:[ICOffineCacheView class] backgroundColor:kClearColor];
    _historyView = [self addViewWithFrame:self.bounds class:[ICHistoryView class] backgroundColor:kClearColor];
    _versionView = [self addViewWithFrame:self.bounds class:[ICVersionView class] backgroundColor:kClearColor];
    _feedbackView = [self addViewWithFrame:self.bounds class:[ICFeedbackView class] backgroundColor:kClearColor];
    
    _basicInformationView.hidden  = NO;
    _basicSettingView.hidden      = YES;
    _collectionProgramView.hidden = YES;
    _fansListView.hidden          = YES;
    _offineCacheView.hidden       = YES;
    _historyView.hidden           = YES;
    _versionView.hidden           = YES;
    _feedbackView.hidden          = YES;
    
  }
  return self;
}

@end
