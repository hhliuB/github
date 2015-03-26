//
//  HPBottomViewProtocol.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/18.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HPBottomView.h"
#import "HomePageViewController.h"

@interface HPBottomViewProtocol : NSObject
<HPBottomViewDelegate>

@property (nonatomic,weak) HomePageViewController *controller;

@end
