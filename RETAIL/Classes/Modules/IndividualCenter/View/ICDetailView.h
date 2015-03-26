//
//  ICDetailView.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCView.h"

#import "ICBasicInformationView.h"
#import "ICBasicSettingView.h"
#import "ICCollectionProgramView.h"
#import "ICFansListView.h"
#import "ICOffineCacheView.h"
#import "ICHistoryView.h"
#import "ICVersionView.h"
#import "ICFeedbackView.h"

@interface ICDetailView : DCView

@property (nonatomic,readonly) ICBasicInformationView  *basicInformationView;
@property (nonatomic,readonly) ICBasicSettingView      *basicSettingView;
@property (nonatomic,readonly) ICCollectionProgramView *collectionProgramView;
@property (nonatomic,readonly) ICFansListView          *fansListView;
@property (nonatomic,readonly) ICOffineCacheView       *offineCacheView;
@property (nonatomic,readonly) ICHistoryView           *historyView;
@property (nonatomic,readonly) ICVersionView           *versionView;
@property (nonatomic,readonly) ICFeedbackView          *feedbackView;

@end
