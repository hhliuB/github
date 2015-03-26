
/******************************************************************************
 *  @file   : SettingsView.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-16
 *  @brief  : 【设置】视图
 ******************************************************************************/

#import "SettingsView.h"

@interface SettingsView ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SettingsView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat w = CGRectGetWidth(frame);
    CGFloat h = CGRectGetHeight(frame);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, w, h - 50)];
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
  }
  return self;
}

@end
