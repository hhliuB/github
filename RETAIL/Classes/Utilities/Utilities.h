//
//  Utilities.h
//  RETAIL
//
//  Created by Duke Cui on 15/2/2.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+ (NSString *)distanceStringByMeter:(NSInteger)m;

+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

@end
