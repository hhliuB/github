//
//  HPConrentView.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/17.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCView.h"

#import "DCSegmentButton.h"
#import "HPBottomView.h"

@interface HPContentView : DCView

@property (nonatomic,readonly) DCSegmentButton *segmentButton;

@property (nonatomic,readonly) UITableView *recommentTableView;
@property (nonatomic,readonly) UITableView *hitTableView;

@property (nonatomic,readonly) HPBottomView *bottomView;

@end
