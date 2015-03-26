//
//  SearchTableViewProtocol.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SearchViewController.h"

@interface SearchTableViewProtocol : NSObject
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) SearchViewController *controller;

@end
