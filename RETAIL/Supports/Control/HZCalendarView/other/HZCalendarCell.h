//
//  InfiniteCalendarTableViewCell.h
//  SalesMOUDCalendar
//
//  Created by Hang Zhang on 8/27/13.
//  Copyright (c) 2013 Hang Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZCalendarDataSouce.h"
#import "HZCalendarCommon.h"

#define kMonthLineHeight  38
#define kDayButtonWidth   26
#define kDayButtonHeight  kDayButtonWidth
#define kDayLineHeight    (kDayButtonWidth + 12)
#define kMaxButtonLeftAndRightInset 60.0f

@protocol HZCalendarCellDelegate;

@interface HZCalendarCell : UITableViewCell

+ (int)getFirstDayIndex:(int)dayOfWeekOfFirstDay
            firtDayMode:(CalendarMonthFirstWeekDay)firtDayMode;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
       firstDayMode:(CalendarMonthFirstWeekDay)firstDayMode
              width:(CGFloat)width;


@property(nonatomic,readonly,strong) HZCalendarMonthItem* config;
@property(nonatomic,assign) id<HZCalendarCellDelegate> delegate;

- (void)setConfigItem:(HZCalendarMonthItem*)config;
- (void)clean;
- (void)cleanDaySelectState;

@end


@protocol HZCalendarCellDelegate <NSObject>

- (void)calendarCell:(HZCalendarCell*)cell didSelectDay:(int)day;

@end

