//
//  ICOffineCacheViewProtocol.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/23.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndividualCenterViewController.h"

@interface ICOffineCacheViewProtocol : NSObject
<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) IndividualCenterViewController *controller;

@end
