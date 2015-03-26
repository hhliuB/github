
/******************************************************************************
 *  @file   : SettingsProtocol.m
 *  @author : <#author#>
 *  @date   : 2014-09-16
 *  @brief  : 【设置】数据源及代理
 ******************************************************************************/

#import "SettingsProtocol.h"
#import "SettingsCell.h"

@implementation SettingsProtocol

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"settings cell";
  
  SettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
    cell = [[SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  cell.titleLabel.text = [NSString stringWithFormat:@"设置 %d", indexPath.row + 1];
  cell.onOff.on = YES;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  SettingsCell *cell = (SettingsCell *)[tableView cellForRowAtIndexPath:indexPath];
  [cell.onOff setOn:!cell.onOff.isOn animated:YES];
}

@end
