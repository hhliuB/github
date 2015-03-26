//
//  SearchTableViewProtocol.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "SearchTableViewProtocol.h"

static NSString *titles[] = {@"锦绣缘华丽冒险",
                             @"封神英雄榜2",
                             @"平凡的世界",
                             @"名侦探狄仁杰",
                             @"敢爱",
                             @"少年四大名捕",
                             @"千金女贼",
                             @"熊出没",
                             @"神雕侠侣",
                             @"石敢当之雄峙天东"};

@implementation SearchTableViewProtocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"%d . %@",indexPath.row + 1,titles[indexPath.row % 10]];
  if (indexPath.row < 3) {
    cell.textLabel.textColor = kMainColor;
  }
  else {
    cell.textLabel.textColor = kTextColor;
  }
  cell.textLabel.font = kLargerFont;
  
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.controller searchMovieWithString:titles[indexPath.row % 10]];
}

@end
