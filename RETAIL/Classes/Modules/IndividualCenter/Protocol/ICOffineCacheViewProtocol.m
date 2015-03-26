//
//  ICOffineCacheViewProtocol.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/23.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICOffineCacheViewProtocol.h"


@implementation ICOffineCacheViewProtocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  //  ICProgramCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
  //  if (cell == nil) {
  //    ICProgramCell * cell = [[ICProgramCell alloc]init];
  //  }
  
  //  cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row]];
  UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
  if (cell == nil) {
    cell = [[UICollectionViewCell alloc]init];
  }
  
  UIImageView * iconImage = [cell.contentView addViewWithFrame:CGRectMake(10, 10, 200, 200) class:[UIImageView class] backgroundColor:kBlueColor];
  iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_small_top%d",(int)indexPath.row]];
  
  UIView *coverView = [cell.contentView addViewWithFrame:CGRectMake(10, 210, 200, 50) class:[UIView class] backgroundColor:kWhiteColor];
  
  UILabel * titleLabel = [coverView addLabelWithFrame:CGRectMake(10, 5, 180, 20) text:@"撒娇女人最好命" textColor:kTextColor font:kLargerFont];
  titleLabel.textAlignment = NSTextAlignmentCenter;
  
  UILabel * percentageLabel = [coverView addLabelWithFrame:CGRectMake(10, 30, 180, 20) text:@"已观看 90%" textColor:kTextColor font:kDefaultFont];
  percentageLabel.textAlignment = NSTextAlignmentCenter;
  
  
  //  UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 200, 200)];
  //  imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",(indexPath.section * 4 + indexPath.item) % 11]];
  //
  //  [cell.contentView addSubview:imageView];
  //  imageView.backgroundColor = kLightBlueColor;
  //
  //  UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, cell.frame.size.width, 30)];
  //  lable.text = [NSString stringWithFormat:@"第 %d 段 %d 列 %d 行 ",indexPath.section,indexPath.item,indexPath.row];
  //  lable.textColor = kTextColor;
  //  //  lable.textAlignment = NSTextAlignmentCenter;
  //  [imageView addSubview:lable];
  
  //  cell.backgroundColor = kLightBlueColor;
  
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(220, 270);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  [self.controller selectMovieForIndexPath:indexPath];
}

@end
