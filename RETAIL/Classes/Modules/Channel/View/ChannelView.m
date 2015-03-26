//
//  ChannelView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/19.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ChannelView.h"

@implementation ChannelView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    self.headerView = [self addViewWithFrame:CGRectMake(0, 0, width, 60) class:[HPHeaderView class] backgroundColor:kLightGrayColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 62, width, 50)];
    CGPoint pointCenter = self.tableView.center;
    
       
    self.tableView.transform       = CGAffineTransformMakeRotation(-M_PI /2);
    self.tableView.frame           = CGRectMake(0, 62, width, 50);
    self.tableView.center          = pointCenter;
    
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.tableView];
    
    [self addViewWithFrame:CGRectMake(20, 113, width - 40, 2) class:[UIView class] backgroundColor:kLineColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection: UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 115, width, height - 115) collectionViewLayout:flowLayout];

    self.collectionView.backgroundColor = kClearColor;
    
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionView"];
    
  }
  return self;
}

@end
