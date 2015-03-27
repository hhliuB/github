//
//  ICBasicInformationView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICBasicInformationView.h"

// 基本信息

@implementation ICBasicInformationView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat y = 50;
    CGFloat x = 60;
    
    _iconImage = [self addViewWithFrame:CGRectMake(x, y, 100, 100)
                                  class:[UIImageView class]
                        backgroundColor:kBlueColor];
    _iconImage.layer.cornerRadius = 50;
    
    _nameLabel = [self addLabelWithFrame:CGRectMake(x + 120, y, 300, 40)
                                    text:nil
                               textColor:kTextColor
                                    font:kLargestFont];
    
    _descriptionLabel = [self addLabelWithFrame:CGRectMake(x + 120, y + 40, 300, 50)
                                           text:nil
                                      textColor:kTextColor
                                           font:kDefaultFont];
    _descriptionLabel.numberOfLines = 0;
    
    y += 130;
    
    [self addViewWithFrame:CGRectMake(x, y - 10, self.width - 100, 2)
                     class:[UIView class]
           backgroundColor:kLineColor];
    
    _nickNameLabel = [self addLabelWithFrame:CGRectMake(x, y, 300, 40)
                                        text:nil
                                   textColor:kTextColor
                                        font:kLargerFont];

    y += 30;
    _genderLabel = [self addLabelWithFrame:CGRectMake(x, y, 300, 30)
                                      text:nil
                                 textColor:kTextColor
                                      font:kLargerFont];
    y += 30;
    
    _favoritesCount = [self addLabelWithFrame:CGRectMake(x, y, 300, 30)
                                         text:nil
                                    textColor:kTextColor
                                         font:kLargerFont];
    y += 30;
    
    _videosCount    = [self addLabelWithFrame:CGRectMake(x, y, 300, 30)
                                         text:nil
                                    textColor:kTextColor
                                         font:kLargerFont];
    y += 30;
    
    _fansCount      = [self addLabelWithFrame:CGRectMake(x, y, 300, 30)
                                         text:nil
                                    textColor:kTextColor
                                         font:kLargerFont];
    y += 30;
    
    _followingCount = [self addLabelWithFrame:CGRectMake(x, y, 300, 30)
                                         text:nil
                                    textColor:kTextColor
                                         font:kLargerFont];
    
    y += 30;
    
    _registTime     = [self addLabelWithFrame:CGRectMake(x, y, 300, 30)
                                         text:nil
                                    textColor:kTextColor
                                         font:kLargerFont];
    
    y += 30;
  }
  return self;
}

@end
