//
//  HZCalendarHeaderView.m
//  SalesMOUDCalendar
//
//  Created by Hang Zhang on 9/2/13.
//  Copyright (c) 2013 Hang Zhang. All rights reserved.
//

#import "HZCalendarHeaderView.h"

static NSString* sundayFirstTitle[7] = {
  @"日",
  @"一",
  @"二",
  @"三",
  @"四",
  @"五",
  @"六"
};

static NSString* mondayFirstTitle[7] = {
  @"一",
  @"二",
  @"三",
  @"四",
  @"五",
  @"六",
  @"日"};

#define kReloadDistance 10

@interface HZCalendarHeaderView()

@end

@implementation HZCalendarHeaderView

- (id)initWithFrame:(CGRect)frame
       firstDayMode:(CalendarMonthFirstWeekDay)firstDayMode{
  self  = [super initWithFrame:frame];
  if(self){
    [self setClipsToBounds:YES];
    [self setBackgroundColor:kCalendarHeaderViewBackground];
    
    int w = 30, h = 30;
    for (int i = 0; i < 7; i++) {
      CGRect titleFrame = CGRectMake(((self.frame.size.width - w * 7) / 6  + w) * i,
                                     10,
                                     w,
                                     h);
      UILabel* dayOfWeekTitle = [[UILabel alloc] initWithFrame:titleFrame];
      [dayOfWeekTitle setBackgroundColor:kGrayColor];
      [dayOfWeekTitle setFont:[UIFont systemFontOfSize:14]];
      [dayOfWeekTitle setTextAlignment:NSTextAlignmentCenter];
      [dayOfWeekTitle setTextColor:kTextColor];
      if(firstDayMode == CalendarMonthFirstWeekDayMonday){
        [dayOfWeekTitle setText:mondayFirstTitle[i]];
      }else if(firstDayMode == CalendarMonthFirstWeekDaySunday){
        [dayOfWeekTitle setText:sundayFirstTitle[i]];
      }
      
      if(i == 0 || i == 6){
        [dayOfWeekTitle setTextColor:kTextColor];
      }
      
      [self addSubview:dayOfWeekTitle];
      [self apllyBottomLine];
    }
  }
  return self;
}

- (void)apllyBottomLine{
  CALayer *bottomBorder = [CALayer layer];
  
  bottomBorder.frame = CGRectMake(0.0f,
                                  self.frame.size.height - 1,
                                  self.frame.size.width,
                                  1.0f);
  
  bottomBorder.backgroundColor = kLineColor.CGColor;
  [self.layer addSublayer:bottomBorder];
}

@end
