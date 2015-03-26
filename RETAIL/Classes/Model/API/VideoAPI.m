//
//  VideoAPI.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/26.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "VideoAPI.h"

#import "VideoBiz.h"

@interface VideoAPI()

@property (nonatomic,strong) VideoBiz *videoBiz;

@end

@implementation VideoAPI

- (void)getVideos
{
  [self.videoBiz getVideos];
}

- (VideoBiz *)videoBiz
{
  return GetInstance(VideoBiz, _videoBiz);
}

@end
