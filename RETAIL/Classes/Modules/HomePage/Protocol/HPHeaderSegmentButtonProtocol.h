//
//  HPHeaderSegmentButtonProtocol.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/18.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DCSegmentButton.h"
#import "HomePageViewController.h"

@interface HPHeaderSegmentButtonProtocol : NSObject
<DCSegmentButtonDelegate>

@property (nonatomic,weak) HomePageViewController *controller;

@end
