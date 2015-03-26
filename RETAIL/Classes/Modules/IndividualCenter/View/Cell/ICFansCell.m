//
//  ICFansCell.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/23.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICFansCell.h"

@implementation ICFansCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
        
    _iconImage = [self addViewWithFrame:CGRectMake(15, 15, 60, 60) class:[UIImageView class] backgroundColor:kBlueColor];
    _iconImage.layer.cornerRadius = 30;
    
    _nameLabel = [self addLabelWithFrame:CGRectMake(90, 15, 150, 15) text:nil textColor:kTextColor font:kDefaultFont];
    
    _descriptionLabel = [self addLabelWithFrame:CGRectMake(90, 30, 500, 30) text:nil textColor:kTextColor font:kSmallerFont];
    _descriptionLabel.numberOfLines = 0;
    
    _fansCount = [self addLabelWithFrame:CGRectMake(90, 60, 80, 15) text:nil textColor:kTextColor font:kSmallerFont];
    [self addViewWithFrame:CGRectMake(170, 60, 2, 15) class:[UIView class] backgroundColor:kLineColor];
    _videosCount = [self addLabelWithFrame:CGRectMake(180, 60, 80, 15) text:nil textColor:kTextColor font:kSmallerFont];
    
    _followingImage = [self addViewWithFrame:CGRectMake(635, 30, 60, 30) class:[UIImageView class] backgroundColor:kWhiteColor];
    _followingImage.layer.cornerRadius = 5;
    
    _followingLabel = [self addLabelWithFrame:CGRectMake(640, 30, 50, 30) text:nil textColor:kTextColor font:kDefaultFont];
    _followingLabel.textAlignment = NSTextAlignmentCenter;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

@end
