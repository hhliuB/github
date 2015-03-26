//
//  ChannelCollectionViewProtocol.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/19.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ChannelCollectionViewProtocol.h"

@implementation ChannelCollectionViewProtocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
  if (cell == nil) {
    cell = [[UICollectionViewCell alloc]init];
  }

  
  UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 200, 200)];
  imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_small_top%d",(indexPath.section * 4 + indexPath.item) % 11]];
  
  [cell.contentView addSubview:imageView];
  imageView.backgroundColor = kLightBlueColor;
  
  UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, cell.frame.size.width, 30)];
  lable.text = [NSString stringWithFormat:@"第 %d 段 %d 列 %d 行 ",indexPath.section,indexPath.item,indexPath.row];
  lable.textColor = kTextColor;
//  lable.textAlignment = NSTextAlignmentCenter;
  [imageView addSubview:lable];
  
//  cell.backgroundColor = kLightBlueColor;
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(220, 220);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  [self.controller selectMovieForIndexPath:indexPath];
}


@end
