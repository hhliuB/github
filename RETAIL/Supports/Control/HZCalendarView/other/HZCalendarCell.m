//
//  InfiniteCalendarTableViewCell.m
//  SalesMOUDCalendar
//
//  Created by Hang Zhang on 8/27/13.
//  Copyright (c) 2013 Hang Zhang. All rights reserved.
//

#import "HZCalendarCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+Extensions.h"

@interface HZCalendarCell(){
  UIButton* _lastSelectedButton;
  NSArray* _dayButtons;
  UILabel* _monthLabel;
  NSArray* _lines;
  CalendarMonthFirstWeekDay _firstDayMode;
  NSArray* _indicationDots;
  CGFloat _defualtWidth;
}

//update methods
- (void)updateDayButtonsAndIndicator;
- (void)updateLines;
- (void)updateMonthLabel;

//other
- (void)dayButtonPressed:(UIButton*)sender;
- (UIColor *)getButtonNormalTextColorWithIndex:(int)index;
@end

@implementation HZCalendarCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
       firstDayMode:(CalendarMonthFirstWeekDay)firstDayMode
              width:(CGFloat)width{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if(self){
    _defualtWidth = width;
    _firstDayMode = firstDayMode;
    
    [self setClipsToBounds:YES];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    NSMutableArray* dayButtons =      [[NSMutableArray alloc]  init];
    NSMutableArray* lines      =      [[NSMutableArray alloc]  init];
    NSMutableArray* indicationDots = [[NSMutableArray alloc] init];

    UIImage* blueCircle = [UIImage imageNamed:@"circle_5"];
    UIImage* grayCircle = [UIImage imageNamed:@"HZgrayCircle"];

    CGFloat buttonWidthInterval =(_defualtWidth - kDayButtonWidth * 7) / 7;
    CGFloat buttonLeftAndRightInset = buttonWidthInterval / 2;
    if(buttonLeftAndRightInset > kMaxButtonLeftAndRightInset){
      buttonLeftAndRightInset = kMaxButtonLeftAndRightInset;
    }

    for (int i = 0; i < 6; i++) {
      CGFloat buttonY = i * kDayLineHeight + kMonthLineHeight + 3;

      for (int j = 0; j < 7; j++) {
        CGRect dayButtonFrame = CGRectMake((buttonWidthInterval + kDayButtonWidth) * j + buttonLeftAndRightInset,
                                           buttonY,
                                           kDayButtonWidth,
                                           kDayButtonHeight);
        UIButton* dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [dayButton setFrame:dayButtonFrame];
        [dayButton addTarget:self
                      action:@selector(dayButtonPressed:)
            forControlEvents:UIControlEventTouchUpInside];
        [dayButton setTitleColor:[self getButtonNormalTextColorWithIndex:i*7+j]
                        forState:UIControlStateNormal];
        [dayButton setTitleColor:[UIColor whiteColor]
                        forState:UIControlStateSelected];
        [dayButton.layer setMasksToBounds:YES];
        [dayButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [dayButton setHitTestEdgeInsets:UIEdgeInsetsMake(0, -buttonLeftAndRightInset, -10, -buttonLeftAndRightInset)];
        [dayButton setBackgroundImage:blueCircle forState:UIControlStateSelected];
        [dayButton setBackgroundImage:grayCircle forState:UIControlStateHighlighted];
        [self.contentView addSubview:dayButton];
        [dayButtons addObject:dayButton];

        //Indicator
        CGPoint dotCenter = dayButton.center;
        dotCenter.y += (kDayButtonHeight - 10);
        UIImageView* indicationView = [[UIImageView alloc] initWithImage:blueCircle
                                                        highlightedImage:nil];
        [indicationView setFrame:CGRectMake(0, 0, 4, 4)];
        [indicationView setCenter:dotCenter];
        [indicationView setHidden:YES];
        [self.contentView addSubview:indicationView];
        [indicationDots addObject:indicationView];
      }
      //bottom line
      UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, buttonY - 3, _defualtWidth, 1)];
      [lineView setBackgroundColor:kCalendarLineGrayColor];
      [self.contentView addSubview:lineView];

      [lines addObject:lineView];
    }

    _dayButtons     = [NSArray arrayWithArray:dayButtons];
    _lines          = [NSArray arrayWithArray:lines];
    _indicationDots = [NSArray arrayWithArray:indicationDots];
    

    _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 38, kMonthLineHeight - 10)];
//    [_monthLabel setTextColor:kCalendarBlueColor];
    [_monthLabel setTextColor:kMainColor];
    [_monthLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_monthLabel];
  }
  return self;
}


- (void)setConfigItem:(HZCalendarMonthItem*)config{
  _config = config;
  [self updateDayButtonsAndIndicator];
  [self updateLines];
  [self updateMonthLabel];
}

- (void)clean{
  [self cleanDaySelectState];
  [self cleanIndicator];
}
- (void)cleanDaySelectState{
  if(_lastSelectedButton){
    [_lastSelectedButton setSelected:NO];
    _lastSelectedButton = nil;
  }
}

- (void)cleanIndicator{
  for (UIView* indicator in _indicationDots) {
    [indicator setHidden:YES];
  }
}

#pragma mark -
#pragma mark event handle

- (void)dayButtonPressed:(UIButton*)sender{
  if(sender.selected){
    return;
  }
  [UIView animateWithDuration:0.20 animations:^(){
    sender.selected = YES;
  }];
  //  [UIView transitionWithView:sender
  //                    duration:0.20
  //                     options:UIViewAnimationOptionTransitionCrossDissolve
  //                  animations:^{
  //                    sender.selected = YES;
  //                  }
  //                  completion:^(BOOL complete){
  //                    NSLog(@"%@ %@",sender,complete?@"YES":@"NO");
  //                  }];
  [_lastSelectedButton setSelected:NO];
  _lastSelectedButton = sender;
  
  [_delegate calendarCell:self didSelectDay:[sender.currentTitle intValue]];
}



#pragma mark update

- (void)updateDayButtonsAndIndicator{
  int startIndex  = [HZCalendarCell getFirstDayIndex:_config.dayWeekOfFirstDay
                                         firtDayMode:_firstDayMode];
  int daysOfMonth = _config.days;
  
  for(int i =0; i < [_dayButtons count]; i++){
    UIButton* dayButton = _dayButtons[i];
    if(i < startIndex || i >= daysOfMonth + startIndex){
      [dayButton setHidden:YES];
    }else{
      [dayButton setHidden:NO];
      int day =i - startIndex + 1;
      [dayButton setTitle:[NSString stringWithFormat:@"%d",day]
                 forState:UIControlStateNormal];
      
      
      
      if(_config.eventDates && [_config.eventDates indexOfObject:@(day)] != NSNotFound){
        [_indicationDots[i] setHidden:NO];
      }
      
      if (_config.overdueEventDays && [_config.overdueEventDays indexOfObject:@(day)] != NSNotFound) {
//        [_dayButtons[i] setTitleColor:kRedColor forState:UIControlStateNormal];
        [_indicationDots[i] setHidden:NO];
        UIImageView *imageView = _indicationDots[i];
        [imageView setImage:[UIImage imageNamed:@"HZgrayCircle"]];
      }
      
      if (_config.comingEventDays && [_config.comingEventDays indexOfObject:@(day)] != NSNotFound) {
//        [_dayButtons[i] setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_indicationDots[i] setHidden:NO];
        UIImageView *imageView = _indicationDots[i];
        [imageView setImage:[UIImage imageNamed:@"HZgrayCircle"]];
      }
      
      if(_config.selectedDay > 0 && day == _config.selectedDay){
        dayButton.selected = YES;
        _lastSelectedButton = dayButton;
      }
      
      dayButton.tag = day;
    }
  }
}

- (void)updateLines{
  int daysOfMonth = _config.days;
  int startIndex  = [HZCalendarCell getFirstDayIndex:_config.dayWeekOfFirstDay
                                         firtDayMode:_firstDayMode];
  
  int lastDayButtonIndex = startIndex + daysOfMonth - 1;
  UIButton* firstDayButton =_dayButtons[startIndex];
  UIButton* lastDayButton =_dayButtons[lastDayButtonIndex];
  
  
  for (UIView* line in _lines) {
    CGRect lineFrame  = line.frame;
    lineFrame.size.width =  _defualtWidth;
    [line setFrame:lineFrame];
  }
  
  //最下面的横线，在日期没多到进入第五,六行时，隐藏
  BOOL fifthLineHidden =lastDayButtonIndex < 7*4;
  BOOL sixthLineHiden  =lastDayButtonIndex < 7*5;
  [_lines[4] setHidden:fifthLineHidden];
  [_lines[5] setHidden:sixthLineHiden];
  
  UIView* topLine = (UIView*)_lines[0];
  
  CGRect topLineFrame = firstDayButton.frame;
  topLineFrame.size.width  = _defualtWidth - firstDayButton.frame.origin.x;
  topLineFrame.size.height = 1;
  topLineFrame.origin.y = topLine.frame.origin.y;
  [topLine setFrame:topLineFrame];
  
  int bottomLineIndex = 5;
  if(sixthLineHiden){
    if(fifthLineHidden){
      bottomLineIndex = 3;
    }else{
      bottomLineIndex = 4;
    }
  }
  
  UIView* lineUpLastDayButton = (UIView*)_lines[bottomLineIndex];
  CGRect lineFrame = lastDayButton.frame;
  lineFrame.size.width += lineFrame.origin.x;
  lineFrame.origin.x = 0;
  lineFrame.origin.y = lineUpLastDayButton.frame.origin.y;
  lineFrame.size.height = 1;
  [lineUpLastDayButton setFrame:lineFrame];
}

- (void)updateMonthLabel {
  [_monthLabel setText:[NSString stringWithFormat:@"%d月",_config.month]];
//  [_monthLabel setTextColor:_config.monthTitleHighlight?kCalendarBlueColor:kCalendarTextGrayColor];
  [_monthLabel setTextColor:_config.monthTitleHighlight?kMainColor:[UIColor darkGrayColor]];

  [self updateMonthLabelFrame];
}

- (void)updateMonthLabelFrame {
  int startIndex  = [HZCalendarCell getFirstDayIndex:_config.dayWeekOfFirstDay
                                         firtDayMode:_firstDayMode];
  UIButton* firstDayButton = (UIButton*)_dayButtons[startIndex];

  CGPoint center = CGPointMake(firstDayButton.center.x, _monthLabel.center.y);
  [_monthLabel setCenter:center];
}

- (UIColor *)getButtonNormalTextColorWithIndex:(int)index{
  UIColor* color = [UIColor darkGrayColor];
  if(index%7 == 0 || index%7 == 6){
    color = kCalendarTextGrayColor;
  }
  return color;
}

+ (int)getFirstDayIndex:(int)dayOfWeekOfFirstDay
            firtDayMode:(CalendarMonthFirstWeekDay)firtDayMode{
  int startIndex = dayOfWeekOfFirstDay - 1;
  
  if(firtDayMode == CalendarMonthFirstWeekDayMonday){
    startIndex--;
  }
  
  startIndex += 7;
  startIndex %= 7;
  return startIndex;
}

@end
