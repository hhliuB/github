//
//  HZCalendarHeaderView.h
//  SalesMOUDCalendar
//
//  Created by Hang Zhang on 9/2/13.
//  Copyright (c) 2013 Hang Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZCalendarCommon.h"

#define kDefaultCalendarHeaderHeight 50

@interface HZCalendarHeaderView : UIView

- (id)initWithFrame:(CGRect)frame
       firstDayMode:(CalendarMonthFirstWeekDay)firstDayMode;

@end
