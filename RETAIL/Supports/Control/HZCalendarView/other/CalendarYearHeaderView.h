//
//  CalendarYearHeaderView.h
//  WorkingCenter
//
//  Created by Wang Jie on 11/29/13.
//  Copyright (c) 2013 Duke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZCalendarDataSouce.h"

#define kDefaultCalendarYearHeaderHeight 36.0

@class CalendarYearHeaderView;
@protocol CalendarYearHeaderViewDelegate <NSObject>

@required
- (void)calendarHeaderView:(CalendarYearHeaderView *)yearHeaderView didSelectYear:(int)year;
- (void)calendarHeaderView:(CalendarYearHeaderView *)yearHeaderView didScrollToYear:(int)year;

@end

@interface CalendarYearHeaderView : UIView

@property(nonatomic,assign) NSInteger currentYear;

@property(nonatomic,strong) HZCalendarDataSouce* dataSrouce;
@property(nonatomic,assign) id<CalendarYearHeaderViewDelegate> delegate;

@end