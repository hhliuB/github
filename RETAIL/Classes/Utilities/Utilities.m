//
//  Utilities.m
//  RETAIL
//
//  Created by Duke Cui on 15/2/2.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (NSString *)distanceStringByMeter:(NSInteger)m
{
  NSString *str = nil;
  
  if (m < 1000) {
    str = [NSString stringWithFormat:@"%d 米", m];
  }
  else {
    CGFloat km = (CGFloat)m / 1000;
    str = [NSString stringWithFormat:@"%.1f 公里", km];
  }
  
  return str;
}

+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"dd-MM-yyyy"];
  
  NSString * oneDayStr = [dateFormatter stringFromDate:oneDay];
  NSString * anotherDayStr = [dateFormatter stringFromDate:anotherDay];
  NSDate * dateA = [dateFormatter dateFromString:oneDayStr];
  NSDate * dateB = [dateFormatter dateFromString:anotherDayStr];
  
  NSComparisonResult r = [dateA compare:dateB];
  
  if (r == NSOrderedDescending) {
    return 1;
  }
  else if (r == NSOrderedAscending){
    return -1;
  }
  else{
    return 0;
  }
  
}


@end
