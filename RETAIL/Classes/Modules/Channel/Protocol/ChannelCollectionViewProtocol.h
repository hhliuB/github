//
//  ChannelCollectionViewProtocol.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/19.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChannelViewController.h"

@interface ChannelCollectionViewProtocol : NSObject
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) ChannelViewController *controller;

@end
