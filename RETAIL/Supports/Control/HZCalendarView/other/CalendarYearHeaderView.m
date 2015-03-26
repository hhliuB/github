//
//  CalendarYearHeaderView.m
//  WorkingCenter
//
//  Created by Wang Jie on 11/29/13.
//  Copyright (c) 2013 Duke. All rights reserved.
//

#import "CalendarYearHeaderView.h"
#import "HZCalendarDataSouce.h"
#import "HZInfiniteYearScrollView.h"
#import "HZCalendarCommon.h"

#define kDefualtItemCount 100

@interface CalendarYearHeaderView ()
<InfiniteScrollViewDelegate>
{
  HZInfiniteYearScrollView* _yearScrollView;
}

@end

@implementation CalendarYearHeaderView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.clipsToBounds = YES;
    self.backgroundColor = kCalendarHeaderViewBackground;
  }
  return self;
}

- (void)setDataSrouce:(HZCalendarDataSouce *)dataSrouce{
  _dataSrouce = dataSrouce;
  [self setupView];
}

- (void)setCurrentYear:(NSInteger)currentYear {
  if (currentYear == _currentYear) {
    return;
  }
  _currentYear = currentYear;

  [_yearScrollView setSelectedYear:currentYear];
}

#pragma mark setup view

- (void)setupView{
  if (_yearScrollView) {
    [_yearScrollView removeFromSuperview];
    _yearScrollView.delegate = nil;
    _yearScrollView = nil;
  }
  _yearScrollView = [[HZInfiniteYearScrollView alloc] initWithFrame:self.bounds
                                                               year:_dataSrouce.yearOfToday];
  _yearScrollView.delegate = self;
  [self addSubview:_yearScrollView];
}


#pragma mark private
- (void)scrollToNearestYear
{
  UILabel* firstLabel =(UILabel*)_yearScrollView.visibleLabels[0];

  if(fabs(firstLabel.frame.origin.x - _yearScrollView.contentOffset.x) > 0.01){
    CGPoint firstLabelOffset = firstLabel.frame.origin;
    firstLabelOffset.x += 1;
    [_yearScrollView setContentOffset:firstLabelOffset animated:YES];
  }
}

#pragma mark - InfiniteScrollViewDelegate
- (void)infiniteScrollView:(HZInfiniteYearScrollView *)scrollView
           didScrollToYear:(int)year
{
  [_delegate calendarHeaderView:self didScrollToYear:year];
}

- (void)infiniteScrollView:(HZInfiniteYearScrollView *)scrollView
             didSelectYear:(int)year
                    offset:(CGPoint)offset
{
  [self setCurrentYear:year];

  [_delegate calendarHeaderView:self didSelectYear:year];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if(!decelerate){
    [self scrollToNearestYear];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  [self scrollToNearestYear];
}

@end
