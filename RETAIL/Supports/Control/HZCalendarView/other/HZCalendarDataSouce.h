//
//  CalendarDataSouce.h
//  SalesMOUDCalendar
//
//  Created by Hang Zhang on 8/27/13.
//  Copyright (c) 2013 Hang Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HZCalendarMonthItem : NSObject

@property(nonatomic) NSInteger month;
@property(nonatomic) NSInteger year;
@property(nonatomic) NSInteger days;
@property(nonatomic) NSInteger dayWeekOfFirstDay;
@property(nonatomic) NSInteger selectedDay;
@property(nonatomic) NSArray*  eventDates;
@property(nonatomic) NSArray*  overdueEventDays;
@property(nonatomic) NSArray*  comingEventDays;
@property(nonatomic) BOOL monthTitleHighlight;
@end


@interface HZCalendarDataSouce : NSObject

@property(nonatomic) NSInteger yearOfToday;
@property(nonatomic) NSInteger monthOfToday;
@property(nonatomic) NSInteger dayOfToday;

- (void)setEventDays:(NSArray *)eventDays;
- (void)setOverdueEventDays:(NSArray *)overdueEventDays;
- (void)setComingEventDays:(NSArray *)comingEventDays;
- (HZCalendarMonthItem *)getMonthItemByIndexPath:(NSIndexPath *)indexPath;
- (void)loadMoreItemsToTop:(int)count;

//返回偏移量
- (NSInteger)getReadySwitchToYear:(int)year;
- (void)setSelectedDay:(int)day inMonth:(int)month inYear:(int)year;

@end
