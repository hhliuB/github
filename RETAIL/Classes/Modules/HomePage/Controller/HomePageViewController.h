//
//  HomePageViewController.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/16.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCViewController.h"

@interface HomePageViewController : DCViewController

- (void)showRecommentTableView;
- (void)showHitTableView;

- (void)selectMovieAtIndexPath:(NSIndexPath *)indexPath;

@end
