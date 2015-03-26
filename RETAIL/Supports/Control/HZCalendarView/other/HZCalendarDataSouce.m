//
//  CalendarDataSouce.m
//  SalesMOUDCalendar
//
//  Created by Hang Zhang on 8/27/13.
//  Copyright (c) 2013 Hang Zhang. All rights reserved.
//

#import "HZCalendarDataSouce.h"

#define kDefualtItemsCountToAdd 50

@interface HZCalendarMonthItem(){}
@end

@implementation HZCalendarMonthItem
@end

@interface HZCalendarDataSouce(){
  NSDateComponents* _startDateComponents;
  NSDateComponents* _sharedComponents;
  NSCalendar *_calendar;
  NSDateComponents*  _offsetComponents;
  NSDate* _startDate;
  NSMutableDictionary* _events;
  NSMutableArray* _overdueEventDays;
  NSMutableArray* _comingEventDays;
  //用户选中的日期
  int _selectedDay;
  int _selectedYear;
  int _selectedMonth;
}


- (NSInteger)getWeekDay:(NSDate *)date;
- (NSInteger)getDaysOfMonth:(NSDate *)date;
- (NSDate*)addYear:(int)yearDiff toDate:(NSDate*)date;
- (void)processBasicMonthInfo:(HZCalendarMonthItem*)item
                    indexPath:(NSIndexPath*)indexPath;
- (void)processMonthTitleHighlight:(HZCalendarMonthItem*)item;
- (void)processEventDay:(HZCalendarMonthItem*)item;

@end

@implementation HZCalendarDataSouce

- (id)init
{
  self = [super init];
  if(self) {
    _startDate = [NSDate date];
    _calendar = [NSCalendar currentCalendar];
//    [_calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    _startDateComponents = [_calendar components:(NSCalendarUnitYear |
                                                  NSCalendarUnitMonth|
                                                  NSCalendarUnitDay)
                                        fromDate:_startDate];
    [_startDateComponents setCalendar:_calendar];
    _offsetComponents = [_calendar components:(NSCalendarUnitYear  |
                                               NSCalendarUnitMonth |
                                               NSCalendarUnitDay)
                                     fromDate:_startDate];
    
    
    _sharedComponents = [_calendar components:(NSCalendarUnitYear  |
                                               NSCalendarUnitMonth |
                                               NSCalendarUnitDay)
                                     fromDate:[NSDate date]];
    
    _yearOfToday  = [_sharedComponents year];
    _monthOfToday = [_sharedComponents month];
    _dayOfToday   = [_sharedComponents day];
  }
  return self;
}

- (void)loadMoreItemsToTop:(int)count{
  _startDate = [self addYear:-count toDate:_startDate];
  _startDateComponents = [_calendar components:(NSCalendarUnitYear  |
                                                NSCalendarUnitMonth |
                                                NSCalendarUnitDay)
                                      fromDate:_startDate];
}

- (HZCalendarMonthItem*)getMonthItemByIndexPath:(NSIndexPath*)indexPath{
  HZCalendarMonthItem* item = [[HZCalendarMonthItem alloc] init];
  [self processBasicMonthInfo:item indexPath:indexPath];
  [self processMonthTitleHighlight:item];
  [self processEventDay:item];
  
  return  item;
}


- (void)setSelectedDay:(int)day inMonth:(int)month inYear:(int)year
{
  _selectedDay   = day;
  _selectedMonth = month;
  _selectedYear  = year;
}

- (void)setEventDays:(NSArray*)eventDays
{
  _events = [[NSMutableDictionary alloc] init];
  for (NSDate* date in eventDays) {
    NSDateComponents* sharedComponents = [_calendar components:(NSCalendarUnitYear  | NSCalendarUnitMonth |
                                                                NSCalendarUnitDay)
                                                      fromDate:date];
    
    int year  = [sharedComponents year];
    int month = [sharedComponents month];
    int day   = [sharedComponents day];
    
    NSString *yearKey =[NSString stringWithFormat:@"%d",year];
    NSMutableDictionary *yearDic =[_events valueForKey:yearKey];
    if(!yearDic){
      yearDic = [[NSMutableDictionary alloc] init];
      [_events setObject:yearDic forKey:yearKey];
    }
    
    NSString* monthKey =[NSString stringWithFormat:@"%d",month];
    NSMutableArray* monthDic =[yearDic valueForKey:monthKey];
    if(!monthDic){
      monthDic = [[NSMutableArray alloc] init];
      [yearDic setObject:monthDic forKey:monthKey];
    }
    [monthDic addObject:@(day)];
  }
}

- (void)setOverdueEventDays:(NSArray *)overdueEventDays
{
  _overdueEventDays = [[NSMutableArray alloc] init];
  for (NSDate* date in overdueEventDays) {
    NSDateComponents* sharedComponents = [_calendar components:(NSCalendarUnitYear  |
                                                                NSCalendarUnitMonth |
                                                                NSCalendarUnitDay)
                                                      fromDate:date];

    int month = [sharedComponents month];
    int day   = [sharedComponents day];

    if (month == _monthOfToday) {
      [_overdueEventDays addObject:@(day)];
    }
  }
}

- (void)setComingEventDays:(NSArray *)comingEventDays
{
  _comingEventDays = [[NSMutableArray alloc] init];
  for (NSDate* date in comingEventDays) {
    NSDateComponents* sharedComponents = [_calendar components:(NSCalendarUnitYear  |
                                                                NSCalendarUnitMonth |
                                                                NSCalendarUnitDay)
                                                      fromDate:date];

    int month = [sharedComponents month];
    int day   = [sharedComponents day];

    if (month == _monthOfToday) {
      [_comingEventDays addObject:@(day)];
    }
  }
}

//返回偏移量
- (NSInteger)getReadySwitchToYear:(int)year{
  int currentStartYear = [_startDateComponents year];
  
  if(currentStartYear == year){
    return 0;
  }
  
  int offset = year - year % kDefualtItemsCountToAdd - currentStartYear;
  
  _startDate = [self addYear:offset toDate:_startDate];
  _startDateComponents = [_calendar components:(NSCalendarUnitYear  |
                                           NSCalendarUnitMonth |
                                           NSCalendarUnitDay)
                                 fromDate:_startDate];
  
  return year%kDefualtItemsCountToAdd;
}

#pragma mark -
#pragma mark private

- (NSInteger)getWeekDay:(NSDate *)date{
  NSDateComponents *weekdayComponents =
  [_calendar components:(NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
  NSInteger weekday = [weekdayComponents weekday];
  return weekday;
}

- (NSInteger)getDaysOfMonth:(NSDate *)date{
  NSRange days = [_calendar rangeOfUnit:NSCalendarUnitDay
                            inUnit:NSCalendarUnitMonth
                           forDate:date];
  
  return days.length;
}

- (NSDate*)addYear:(int)yearDiff toDate:(NSDate*)date{
  [_offsetComponents setYear:yearDiff];
  return [_calendar dateByAddingComponents:_offsetComponents
                               toDate:date
                              options:NSCalendarWrapComponents];
}

- (void)processBasicMonthInfo:(HZCalendarMonthItem*)item
                    indexPath:(NSIndexPath*)indexPath{
  item.year = [_startDateComponents year] + indexPath.section;
  item.month = indexPath.row + 1;
  
  NSDate* firstDayofMonth;
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setMonth:item.month];
  [components setYear:item.year];
  firstDayofMonth = [_calendar dateFromComponents:components];
  
  item.days = [self getDaysOfMonth:firstDayofMonth];
  item.dayWeekOfFirstDay = [self getWeekDay:firstDayofMonth];
  
  
  if(item.year == _selectedYear && item.month == _selectedMonth){
    item.selectedDay = _selectedDay;
  }
}

- (void)processMonthTitleHighlight:(HZCalendarMonthItem*)item{
  item.monthTitleHighlight =  (item.year == _yearOfToday && item.month == _monthOfToday);
}

- (void)processEventDay:(HZCalendarMonthItem*)item{
  NSString* yearKey =[NSString stringWithFormat:@"%d",item.year];
  NSMutableDictionary* yearDic =[_events valueForKey:yearKey];
  if(yearDic){
    NSString* monthKey =[NSString stringWithFormat:@"%d",item.month];
    NSMutableArray* monthDic =[yearDic valueForKey:monthKey];
    if(monthDic){
      item.eventDates = monthDic;
    }
  }
}

@end
