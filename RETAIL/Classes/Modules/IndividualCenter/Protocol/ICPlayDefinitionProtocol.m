//
//  ICPlayDefinitionProtocol.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/23.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICPlayDefinitionProtocol.h"

#import "ICDefinitionCell.h"

static NSString *titles[] = {@"标清",
                            @"高清",
                            @"超清"};

@implementation ICPlayDefinitionProtocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"cell";
  ICDefinitionCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    cell = [[ICDefinitionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  cell.textLabel.text = titles[indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.controller selectPlayDefinitionWithString:titles[indexPath.row]];
}

@end
