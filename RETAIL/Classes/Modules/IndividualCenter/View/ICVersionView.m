//
//  ICVersionView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICVersionView.h"

 // 版本信息

@implementation ICVersionView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat y = 30;
    
    [self addLabelWithFrame:CGRectMake((self.width - 200) / 2, y, 200, 40) text:@"视频播放系统" textColor:kMainColor font:kHugeFont];
    y += 40;
    
     [self addLabelWithFrame:CGRectMake((self.width - 150) / 2, y, 150, 40) text:@"iPad V1.0.0" textColor:kTextColor font:kLargestFont];
    y += 100;

    _verstionLabel = [self addLabelWithFrame:CGRectMake((self.width - 600) / 2, y, 600, 40) text:@"  已是最新版本" textColor:kTextColor font:kLargestFont];
    y += 100;
    [_verstionLabel addBorderWithColor:kLineColor width:1];
    _verstionLabel.layer.cornerRadius = 5;
    
    NSString *contentString = @"   基于iOS的视频播放系统是专门为iPad用户量身打造的在线客户端产品。我们拥有同类软件中领先的播放速度，丰富的正版视频内容。\n   视频播放系统是移动互联网方面的新手，贵在新颖，服务客户。";
    _contentLabel = [self addLabelWithFrame:CGRectMake(30, y, self.width - 60, 200) text:contentString textColor:kTextColor font:kLargerFont];
    _contentLabel.numberOfLines = 0;
    
    _myLabel  = [self addLabelWithFrame:CGRectMake(0, self.height - 70, self.width, 25) text:@"11计算机 2 班 刘欢欢 版权所有" textColor:kTextColor font:kDefaultFont];
    _myLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *copyrightLabel = [self addLabelWithFrame:CGRectMake(0, self.height - 50, self.width, 25) text:@"Copyright © 1998 - 2015 南理工太科院11计算机 2 班 刘欢欢 all rights Reserved" textColor:kTextColor font:kDefaultFont];
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
  }
  return self;
}

@end
