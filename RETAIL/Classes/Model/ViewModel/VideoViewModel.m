//
//  VideoViewModel.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/26.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "VideoViewModel.h"

#import "VideoAPI.h"

@interface VideoViewModel()

@property (nonatomic,strong) VideoAPI *videoAPI;

@end

@implementation VideoViewModel

- (void)loadData:(void (^)())completion
{
  for (int i = 0; i < 7; i++) {
    [self.videoAPI videosWithCategory:classifications[i]];
  }
  for (int i = 0; i < 6; i ++) {
    [self.videoAPI videosWithCategory:lives[i]];
  }
}

- (VideoAPI *)videoAPI
{
  return GetInstance(VideoAPI, _videoAPI);
}

@end
