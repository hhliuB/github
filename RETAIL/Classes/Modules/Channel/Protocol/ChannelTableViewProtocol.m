//
//  ChannelTableViewProtocol.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/19.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ChannelTableViewProtocol.h"

#import "ChannelTableViewCell.h"

static NSString *titles[] = {
                              @"体育",
                              @"游戏",
                              @"汽车",
                              @"咨询",
                              @"原创",
                              @"搞笑",
                              @"娱乐"
                            };

@implementation ChannelTableViewProtocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"cell";

  ChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    cell = [[ChannelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  cell.selectionStyle  = UITableViewCellSelectionStyleNone;
  cell.backgroundColor = kClearColor;
  
  cell.textLabel.textAlignment = NSTextAlignmentCenter;
  cell.textLabel.textColor = kTextColor;
  cell.textLabel.text = titles[indexPath.row];
  cell.textLabel.font = kLargestFont;
  cell.textLabel.highlightedTextColor = kMainColor;
  
  cell.transform = CGAffineTransformMakeRotation(M_PI /2);

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"%@",titles[indexPath.row]);
  [self.controller selectChannelForIndex:indexPath.row];
}


@end
