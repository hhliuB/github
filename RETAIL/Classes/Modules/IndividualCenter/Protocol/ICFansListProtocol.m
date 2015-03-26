//
//  ICFansListProtocol.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/23.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICFansListProtocol.h"

#import "ICFansCell.h"

@implementation ICFansListProtocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"cell";
  ICFansCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    cell = [[ICFansCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  cell.nameLabel.text = @"奔跑的蜗牛";
  cell.descriptionLabel.text = @"总觉得，床吧，铺得太整齐会有点安度晚年的意思，嗯，还是凌乱些，显得有朝气!";
  
  cell.fansCount.text = @"粉丝数:6";
  cell.videosCount.text = @"总视频数:100";
  if (indexPath.row % 3 == 0) {
    cell.following = YES;
  }
  
  if (cell.following) {
    [cell.followingImage addBorderWithColor:kBlueColor width:1];
    [cell.followingLabel setText:@"未关注"];
    [cell.followingLabel setTextColor:kMainColor];
  }
  else {
    [cell.followingImage addBorderWithColor:kLineColor width:1];
    [cell.followingLabel setText:@"已关注"];
    [cell.followingLabel setTextColor:kTextColor];
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//  [self.controller selectCacheDefinitionWithString:titles[indexPath.row]];
}


@end
