//
//  HPBottomViewProtocol.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/18.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "HPBottomViewProtocol.h"

static NSString *title[] = {
  @"电影",
  @"电视剧",
  @"动漫",
  @"综艺",
  @"新闻"
};

@interface HPBottomViewProtocol()
<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HPBottomViewProtocol

- (NSInteger)numberOfscrollerViewInBottomtView
{
  return 5;
}

- (UITableView *)bottomView:(HPBottomView *)bottomView greatScrollerViewInBottomView:(NSInteger)index
{
  UITableView *tableView = [[UITableView alloc]init];
  tableView.delegate   = self;
  tableView.dataSource = self;
  tableView.showsHorizontalScrollIndicator = NO;
  tableView.showsVerticalScrollIndicator   = NO;
  tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  tableView.rowHeight      = 180;
  tableView.tag            = index;
  return tableView;
}

- (CGFloat)bottomView:(HPBottomView *)bottomView heightForHeaderInIndex:(NSInteger)index
{
  return 50;
}

- (UIView *)bottomView:(HPBottomView *)bottomView headerOfScrollerViewInIndex:(NSInteger)index
{
  UIView *headerView = [[UIView alloc]init];
  headerView.backgroundColor = kLightGrayColor;
  UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
  titleLabel.text = title[index];
  [titleLabel setTextColor:kTextColor];
  [headerView addSubview:titleLabel];
  return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 160, 180)];
  
  imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_small_top%d",indexPath.row]];
  
  [cell.contentView addSubview:imageView];
  
  cell.transform = CGAffineTransformMakeRotation(M_PI /2);
  cell.backgroundColor = kLightBlueColor;
  cell.selectionStyle  = UITableViewCellSelectionStyleNone;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"点击了第 %d 行 %d 张图片",tableView.tag,indexPath.row);
  [self.controller selectMovieAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:tableView.tag]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

@end
