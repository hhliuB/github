//
//  HZCalendarCommon.h
//  SalesMOUDCalendar
//
//  Created by Hang Zhang on 9/2/13.
//  Copyright (c) 2013 Hang Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCalendarHeaderViewBackground kGrayColor
//#define kCalendarBlueColor [UIColor colorWithRed:0 green:154/255.0 blue:207/255.0 alpha:1]
#define kCalendarTextGrayColor [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1]
#define kCalendarLineGrayColor [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1]


typedef NS_ENUM(NSInteger, CalendarMonthFirstWeekDay) {
  CalendarMonthFirstWeekDaySunday = 0,
  CalendarMonthFirstWeekDayMonday = 1
};

@interface HZCalendarCommon : NSObject

@end
