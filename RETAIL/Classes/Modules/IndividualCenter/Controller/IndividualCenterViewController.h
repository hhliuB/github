//
//  IndividualCenterViewController.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/16.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCViewController.h"

@interface IndividualCenterViewController : DCViewController

- (void)selectListItemAtIndex:(NSInteger)index;

- (void)selectMovieForIndexPath:(NSIndexPath *)indexPath;

- (void)selectPlayDefinitionWithString:(NSString *)string;
- (void)selectCacheDefinitionWithString:(NSString *)string;

@end
