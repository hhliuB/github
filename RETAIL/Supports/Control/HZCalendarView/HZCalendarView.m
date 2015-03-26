//
//  HZCalendarView.m
//  SalesMOUDCalendar
//
//  Created by Hang Zhang on 8/27/13.
//  Copyright (c) 2013 Hang Zhang. All rights reserved.
//
#import "HZCalendarView.h"
#import "HZCalendarDataSouce.h"
#import "HZCalendarCell.h"
#import "HZCalendarHeaderView.h"
#import "CalendarYearHeaderView.h"

#define kReloadDistance 10

static NSString* identifier = @"calendarCell";

@interface HZCalendarView()
<HZCalendarCellDelegate, CalendarYearHeaderViewDelegate>
{
  UITableView *_tableView;

  NSInteger _numberOfSection;
  NSInteger _numberOfRow;
  
  NSDate  *_startDate;
  CGPoint  _lastScrollViewOffset;
  
  CalendarMonthFirstWeekDay _firstDayMode;
  
  NSIndexPath *_currentIndexPath;

  CalendarYearHeaderView *_yearHeaderView;
  HZCalendarHeaderView   *_calHeaderView;
  HZCalendarCell         *_currentHasSelectedDayCell;
  
  BOOL _updating;
  BOOL _needNotifyHeaderView;
  
  UIView *_contentView;

  BOOL _showsYearHeader;
}

@property(nonatomic,readwrite) NSInteger selectedYear;
@property(nonatomic,readwrite) NSInteger selectedMonth;
@property(nonatomic,readwrite) NSInteger selectedDay;

@end

@implementation HZCalendarView

#pragma mark -Public function

- (id)initWithFrame:(CGRect)frame
           firstDay:(CalendarMonthFirstWeekDay)firstDay
{
  self = [super initWithFrame:frame];
  if(self){
    _firstDayMode    = firstDay;
    _numberOfRow     = 12;
    _numberOfSection = 100;

    [self setBackgroundColor:[UIColor whiteColor]];

    CGFloat width = self.bounds.size.width;

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, 64, width, 1);
    bottomBorder.backgroundColor = kLineColor.CGColor;
    [self.layer addSublayer:bottomBorder];

    _contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_contentView];
  }
  return self;
}

- (void)gotoDay:(int)day month:(int)month year:(int)year
{
  [_dataSource setSelectedDay:day inMonth:month inYear:year];
  [self setSelectedDay:day inMonth:month inYear:year];
  
  [_currentHasSelectedDayCell cleanDaySelectState];
  
  int offset = [_dataSource getReadySwitchToYear:_dataSource.yearOfToday];
  if(offset > 0) {
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataSource.monthOfToday -1
                                                          inSection:offset]
                      atScrollPosition:UITableViewScrollPositionTop animated:NO];

    [_yearHeaderView setCurrentYear:year];
  }
  
  _currentHasSelectedDayCell = _tableView.visibleCells[0];
}

- (void)gotoToday
{
  [self gotoDay:_dataSource.dayOfToday
          month:_dataSource.monthOfToday
           year:_dataSource.yearOfToday];
}

- (void)reloadTableView
{
  [_tableView reloadData];
}

- (void)reloadData
{
//  NSLog(@"canlendarView reloadData");
  if(_dataSource){
    [self setupYearHeaderView];
    [self setupCalendarHeaderView];
    [self setupTableView];
    [self showsYearHeader:NO];
    [self addItemsToTop];
    [self gotoToday];
  }
}

- (void)showsYearHeader:(BOOL)shows
{
  if (shows) {
    _yearHeaderView.alpha = 1.0;
    CGRect frame = _contentView.frame;
    frame.origin.y = _yearHeaderView.frame.size.height;
    frame.size.height = self.bounds.size.height - _yearHeaderView.frame.size.height;
    _contentView.frame = frame;
  }
  else {
    _yearHeaderView.alpha = 0.0;
    _contentView.frame = self.bounds;
  }
  _showsYearHeader = shows;
}

- (void)toggleYearHeader
{
  [self showsYearHeader:!_showsYearHeader];
}

#pragma mark -Private function

- (void)setupYearHeaderView {
  if (_yearHeaderView) {
    [_yearHeaderView removeFromSuperview];
  }
  CGRect frame = CGRectMake(0, 0, self.bounds.size.width, kDefaultCalendarYearHeaderHeight);

  _yearHeaderView = [[CalendarYearHeaderView alloc] initWithFrame:frame];
  _yearHeaderView.backgroundColor = kCalendarHeaderViewBackground;
  _yearHeaderView.delegate = self;
  [_yearHeaderView setDataSrouce:_dataSource];
  _yearHeaderView.alpha = 0;
  [self addSubview:_yearHeaderView];
  [self sendSubviewToBack:_yearHeaderView];
}

- (void)setupCalendarHeaderView{
  if(_calHeaderView){
    [_calHeaderView removeFromSuperview];
  }
  CGRect frame =CGRectMake(0, 0, self.bounds.size.width, kDefaultCalendarHeaderHeight);
  _calHeaderView = [[HZCalendarHeaderView alloc] initWithFrame:frame
                                               firstDayMode:_firstDayMode];
  [_contentView addSubview:_calHeaderView];
}

- (void)setupTableView{
  if(_tableView){
    [_tableView removeFromSuperview];
  }
  CGRect frame = self.frame;
  frame.origin.y = kDefaultCalendarHeaderHeight;
  frame.size.height -= kDefaultCalendarHeaderHeight;
  _tableView = [[UITableView alloc] initWithFrame:frame];
  [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
  [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [_tableView setScrollsToTop:NO];
  _tableView.delegate   = self;
  _tableView.dataSource = self;
  _updating =  NO;
  _needNotifyHeaderView = YES;
  _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
  [_contentView addSubview:_tableView];
}

- (void)addItemsToTop{
  _updating = YES;
  int itemsCountToAdd = 50;
  
  NSIndexPath *oldIndexPath = _tableView.indexPathsForVisibleRows[0];
  CGRect before = [_tableView rectForRowAtIndexPath:oldIndexPath];
  CGPoint contentOffset = [_tableView contentOffset];
  
  
  [_dataSource loadMoreItemsToTop:itemsCountToAdd];
  [_tableView reloadData];
  
  NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:oldIndexPath.row
                                                 inSection:oldIndexPath.section + itemsCountToAdd];
  CGRect after = [_tableView rectForRowAtIndexPath:newIndexPath];
  contentOffset.y += (after.origin.y - before.origin.y);
  _tableView.contentOffset = contentOffset;
  _updating = NO;
}

- (void)addItemsToBottom{
  _updating = YES;
  _numberOfSection += 25;
  [_tableView reloadData];
  _updating = NO;
}

- (void)setSelectedDay:(int)day inMonth:(int)month inYear:(int)year
{
  self.selectedDay   = day;
  self.selectedMonth = month;
  self.selectedYear  = year;
}

#pragma mark -UITableViewDataSouce
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  HZCalendarCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if(!cell){
    cell = [[HZCalendarCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                reuseIdentifier:identifier
                                   firstDayMode:_firstDayMode
                                          width:self.frame.size.width];
    
    cell.delegate = self;
  }
  [cell clean];
  [cell setConfigItem:[_dataSource getMonthItemByIndexPath:indexPath]];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
  return _numberOfRow;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return _numberOfSection;
}


#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//  CGFloat h = 360.0;
  HZCalendarMonthItem* configItem = [_dataSource getMonthItemByIndexPath:indexPath];
  
  int startIndex =[HZCalendarCell getFirstDayIndex:configItem.dayWeekOfFirstDay
                                       firtDayMode:_firstDayMode];
  
  int totlaLineCount = (startIndex + configItem.days - 1) / 7 + 1;

  return totlaLineCount * kDayLineHeight + kMonthLineHeight;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if([tableView.visibleCells count] > 0){
    NSIndexPath *firstCellIndexPath = _tableView.indexPathsForVisibleRows[0];
    if(_currentIndexPath == firstCellIndexPath){
      return;
    }
    if(_currentIndexPath){
      HZCalendarMonthItem* item =  [_dataSource getMonthItemByIndexPath:firstCellIndexPath];
      
      
      if(_currentIndexPath.section != firstCellIndexPath.section){
        [_yearHeaderView setCurrentYear:item.year];
      }
      
      if(_currentIndexPath.section != firstCellIndexPath.section){
        if(_delegate && [_delegate respondsToSelector:@selector(calendarViewDidScrollToYear:)]){
          [_delegate calendarViewDidScrollToYear:item.year];
        }
      }
      
      if(_delegate && [_delegate respondsToSelector:@selector(calendarViewDidScrollToYear:month:)]){
        [_delegate calendarViewDidScrollToYear:item.year
                                         month:item.month];
      }
    }
    _currentIndexPath = firstCellIndexPath;
  }
}

#pragma mark -ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

  CGPoint offset = scrollView.contentOffset;
  if(!_updating){
    if (offset.y <= 5 && offset.y < _lastScrollViewOffset.y){
//      NSLog(@"At the top");
      [self addItemsToTop];
      
    }else{
      CGRect bounds = scrollView.bounds;
      CGSize size = scrollView.contentSize;
      UIEdgeInsets inset = scrollView.contentInset;
      CGFloat y = offset.y + bounds.size.height - inset.bottom;
      CGFloat h = size.height;
      
      if(y > h + kReloadDistance) {
//        NSLog(@"load more rows");
        [self addItemsToBottom];
      }
    }
  }
  _lastScrollViewOffset = scrollView.contentOffset;
}


#pragma mark -cell Delegate
- (void)calendarCell:(HZCalendarCell *)cell didSelectDay:(int)day{
  HZCalendarMonthItem* config = cell.config;
  [_dataSource setSelectedDay:day inMonth:config.month inYear:config.year];
  [self setSelectedDay:day inMonth:config.month inYear:config.year];
  if(_currentHasSelectedDayCell != cell){
    [_currentHasSelectedDayCell cleanDaySelectState];
  }
  _currentHasSelectedDayCell = cell;
  
  if(_delegate && [_delegate respondsToSelector:@selector(calendarViewDidSelectedDay:month:year:)]){
    [_delegate calendarViewDidSelectedDay:day
                                    month:config.month
                                     year:config.year];
  }
}

#pragma mark - CalendarYearHeaderViewDelegate
- (void)calendarHeaderView:(CalendarYearHeaderView *)yearHeaderView didScrollToYear:(int)year {

}
- (void)calendarHeaderView:(CalendarYearHeaderView *)yearHeaderView didSelectYear:(int)year {
  int offset = [_dataSource getReadySwitchToYear:year];
  if(offset > 0){
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                          inSection:offset]
                      atScrollPosition:UITableViewScrollPositionTop animated:NO];

    [UIView animateWithDuration:0.4 animations:^{
      [self showsYearHeader:NO];
    }];
  }
//  NSLog(@"HZCalendarHeaderView swich to year: %d",year);
}

@end
