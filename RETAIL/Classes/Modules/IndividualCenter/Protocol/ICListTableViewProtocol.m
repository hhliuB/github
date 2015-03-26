//
//  ICListTableViewProtocol.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICListTableViewProtocol.h"

#import "ICListTableViewCell.h"

static NSString *titles[] = { @"基本信息",
                              @"基本设置",
                              @"收藏节目",
                              @"粉丝列表",
                              @"离线缓存",
                              @"观看历史",
                              @"版本信息",
                              @"意见反馈"};

@implementation ICListTableViewProtocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"cell";
  ICListTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    cell = [[ICListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  cell.imageView.backgroundColor = kRedColor;
  cell.textLabel.text = titles[indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.controller selectListItemAtIndex:indexPath.row];
}

@end
