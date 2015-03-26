
/******************************************************************************
 *  @file   : HRPMenuView.m
 *  @author : HAO RUNPENG
 *  @date   : 2014-08-13
 *  @brief  : 【菜单】视图
 ******************************************************************************/

#import "HRPMenuView.h"

#import "MenuImageStyleCell.h"
#import "MenuTitleStyleCell.h"
#import "MenuImageTextStyleCell.h"

#define kAnimationDuration 0.5

@interface HRPMenuView () <UITableViewDataSource,UITableViewDelegate>
{
  UIButton            *_settingsButton;
  HRPMenuSettingsItem *_settingsItem;
}

@property (nonatomic,readwrite) UITableView *tableView;

@end

@implementation HRPMenuView

- (id)initWithFrame:(CGRect)frame
{
  frame.size.width = 60;

  self = [super initWithFrame:frame];
  if (self) {
    _normalMenuItemsEnabled = YES;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 60, 0)];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.scrollEnabled   = NO;
    [self addSubview:_tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(significantTimeChange:)
                                                 name:UIApplicationSignificantTimeChangeNotification
                                               object:nil];
  }
  return self;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIApplicationSignificantTimeChangeNotification
                                                object:nil];
}

- (void)setMenuItems:(NSArray *)menuItems
{
  _menuItems = menuItems;
  [self resetTableViewFrame];
}

- (void)resetTableViewFrame
{
  CGRect rect = self.tableView.frame;
  float height = self.menuItems.count * 80;
  rect.size.height = height;
  self.tableView.frame = rect;

  CGPoint point = self.tableView.center;
  point.y = self.bounds.size.height / 2;
  self.tableView.center = point;
}

- (void)setNormalMenuItemsEnabled:(BOOL)normalMenuItemsEnabled
{
  _normalMenuItemsEnabled = normalMenuItemsEnabled;
  _tableView.userInteractionEnabled = _normalMenuItemsEnabled;
}

- (void)setSettingsItem:(HRPMenuSettingsItem *)settingsItem
{
  _settingsItem = settingsItem;
  [_settingsButton removeFromSuperview];
  _settingsButton = nil;
  
  CGFloat y = self.frame.size.height - 120;
  
  _settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _settingsButton.backgroundColor = [UIColor clearColor];
  [_settingsButton setFrame:CGRectMake(0, y, 60, 60)];
  [_settingsButton setImage:_settingsItem.normalImage   forState:UIControlStateNormal];
  [_settingsButton setImage:_settingsItem.selectedImage forState:UIControlStateSelected];
  [_settingsButton setImage:_settingsItem.selectedImage forState:UIControlStateHighlighted];
  [_settingsButton addTarget:_settingsItem.target
                      action:_settingsItem.action
            forControlEvents:UIControlEventTouchUpInside];
  [_settingsButton addTarget:self
                      action:@selector(buttonPressed)
            forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_settingsButton];
}

- (void)setSettingsItemEnabled:(BOOL)settingsItemEnabled
{
  _settingsItemEnabled = settingsItemEnabled;
  _settingsButton.enabled = _settingsItemEnabled;
}

- (void)setAllowsReceiveTouch:(BOOL)allowsReceiveTouch
{
  _allowsReceiveTouch = allowsReceiveTouch;
  self.userInteractionEnabled = _allowsReceiveTouch;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
  _selectedIndex = selectedIndex;
  [self selectCurrentMenuItem];
}

- (void)setBadgeNumber:(NSInteger)badgeNumber atIndex:(NSInteger)index
{
  HRPMenuItem *item = _menuItems[index];
  item.badgeNumber = badgeNumber;
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                        withRowAnimation:UITableViewRowAnimationNone];
  
  [self selectCurrentMenuItem];
}

- (void)selectCurrentMenuItem
{
  NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
  [self.tableView selectRowAtIndexPath:selectIndexPath
                              animated:YES
                        scrollPosition:UITableViewScrollPositionNone];
}

- (void)significantTimeChange:(NSNotification *)noti
{
  NSMutableArray *array = [NSMutableArray array];
  
  for (int i = 0; i < [self.menuItems count]; i++) {
    HRPMenuItem *item = self.menuItems[i];
    if (item.style == MenuItemStyleDay || item.style == MenuItemStyleMonth) {
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
      [array addObject:indexPath];
    }
  }
  
  [self.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
  [self selectCurrentMenuItem];
}

- (void)buttonPressed
{
  _settingsButton.selected = !_settingsButton.selected;
}

#pragma mark -
#pragma mark Animation Methods

- (void)rotateSettingsButtonClockwise:(BOOL)clockwise
{
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
  animation.duration            = kAnimationDuration;
  animation.removedOnCompletion = NO;
  animation.fillMode            = kCAFillModeForwards;
  animation.repeatCount         = 1;
  if (clockwise) {
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI, 0, 0, 1.0)];
    animation.toValue   = 0;
  }
  else {
    animation.fromValue = 0;
    animation.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1.0)];
  }
  [_settingsButton.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark -
#pragma mark UITableView Delegate and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.menuItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = nil;
  HRPMenuItem *item = self.menuItems[indexPath.row];
  
  switch (item.style) {
    case MenuItemStyleImage:
      cell = [self tableView:tableView menuImgaeCellForItemAtIndexPath:indexPath];
      break;
    case MenuItemStyleImageText:
      cell = [self tableView:tableView menuCellForItemAtIndexPath:indexPath];
      break;
    default:
      cell = [self tableView:tableView menuTitleCellForItemAtIndexPath:indexPath];
      break;
  }
  return cell;
}

- (MenuImageStyleCell *)tableView:(UITableView *)tableView
  menuImgaeCellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  HRPMenuItem *item = self.menuItems[indexPath.row];
  static NSString *identifier = @"menuOnlyImageCellIdentifier";
  MenuImageStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[MenuImageStyleCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identifier];
  }
  cell.bubble.number                  = item.badgeNumber;
  cell.menuImageView.image            = item.normalImage;
  cell.menuImageView.highlightedImage = item.selectedImage;
  return cell;
}

- (MenuTitleStyleCell *)tableView:(UITableView *)tableView
  menuTitleCellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"menuOnlyTitleCellIdentifier";
  HRPMenuItem *item = self.menuItems[indexPath.row];
  
  NSString  *todayString = [NSString stringWithFormat:@"%ld",(long)[self dayOfToday]] ;
  NSString  *monthString = [self stringOfMonth:[self monthOfToday]];
  
  MenuTitleStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[MenuTitleStyleCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identifier];
  }
  cell.titleLable.textAlignment = NSTextAlignmentCenter;
  cell.titleLable.adjustsFontSizeToFitWidth = YES;
  
  switch (item.style) {
    case MenuItemStyleDay:
      [cell.titleLable setNumberOfLines:2];
      cell.titleLable.text = [NSString stringWithFormat:@"%@\n%@",todayString,monthString];
      cell.titleLable.font = [UIFont systemFontOfSize:14];
      break;
    case MenuItemStyleMonth:
      cell.titleLable.text = [NSString stringWithFormat:@"%@",monthString];
      cell.titleLable.font = [UIFont systemFontOfSize:15];
      break;
    default:
      cell.titleLable.text = item.title;
      cell.titleLable.font = [UIFont systemFontOfSize:17];
      break;
  }
  cell.bubble.number = item.badgeNumber;
  cell.titleLable.highlightedTextColor = item.selectedColor != NULL ? item.selectedColor : [UIColor blueColor];
  return cell;
}

- (MenuImageTextStyleCell *)tableView:(UITableView *)tableView
           menuCellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  HRPMenuItem *item = self.menuItems[indexPath.row];
  static NSString *identifier = @"menuImageTextCellIdentifier";
  MenuImageTextStyleCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[MenuImageTextStyleCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:identifier];
  }
  cell.titleLable.textAlignment        = NSTextAlignmentCenter;
  cell.titleLable.font                 = [UIFont systemFontOfSize:12];
  cell.titleLable.text                 = item.title;
  cell.bubble.number                   = item.badgeNumber;
  cell.menuImageView.image             = item.normalImage;
  cell.menuImageView.highlightedImage  = item.selectedImage;
  cell.titleLable.highlightedTextColor = item.selectedColor != NULL ? item.selectedColor : [UIColor blueColor];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  self.selectedIndex = indexPath.row;
  [self.delegate menuViewDidSelectItemAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark Private methods

- (NSInteger)monthOfToday
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM"];
  NSString *str = [formatter stringFromDate:[NSDate date]];
  return [str integerValue];
}

- (NSInteger)dayOfToday
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"dd"];
  NSString *str = [formatter stringFromDate:[NSDate date]];
  return [str integerValue];
}

- (NSString *)stringOfMonth:(NSInteger)month
{
  NSString *str = nil;
  switch (month) {
	  case 1:str = @"Jan.";break;
	  case 2:str = @"Feb.";break;
	  case 3:str = @"Mar.";break;
	  case 4:str = @"Apr.";break;
	  case 5:str = @"May.";break;
	  case 6:str = @"Jun.";break;
	  case 7:str = @"Jul.";break;
	  case 8:str = @"Aug.";break;
	  case 9:str = @"Sep.";break;
	  case 10:str = @"Oct.";break;
	  case 11:str = @"Nov.";break;
	  case 12:str = @"Dec.";break;
	  default:break;
  }
  return str;
}

@end
