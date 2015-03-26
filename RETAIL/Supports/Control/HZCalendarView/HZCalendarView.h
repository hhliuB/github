//
//  HZCalendarView.h
//  SalesMOUDCalendar
//
//  Created by Hang Zhang on 8/27/13.
//  Copyright (c) 2013 Hang Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZCalendarCommon.h"
#import "HZCalendarDataSouce.h"

@protocol HZCalendarViewDelegate <NSObject>

@optional
- (void)calendarViewDidScrollToYear:(NSInteger)year;
- (void)calendarViewDidScrollToYear:(NSInteger)year
                              month:(NSInteger)month;
- (void)calendarViewDidSelectedDay:(NSInteger)day
                             month:(NSInteger)month
                              year:(NSInteger)year;
@end

@protocol HZCalendarViewDelegate;
@interface HZCalendarView : UIView <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic) id<HZCalendarViewDelegate> delegate;
@property(nonatomic) HZCalendarDataSouce* dataSource;

@property(nonatomic,readonly) NSInteger selectedYear;
@property(nonatomic,readonly) NSInteger selectedMonth;
@property(nonatomic,readonly) NSInteger selectedDay;

- (id)initWithFrame:(CGRect)frame firstDay:(CalendarMonthFirstWeekDay)firstDay;

- (void)gotoDay:(int)day month:(int)month year:(int)year;
- (void)gotoToday;

- (void)reloadTableView;

- (void)reloadData;

- (void)showsYearHeader:(BOOL)shows;
- (void)toggleYearHeader;

@end
