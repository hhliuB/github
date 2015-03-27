//
//  VideoAPI.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/26.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "VideoAPI.h"

#import "VideoBiz.h"

#import "VideoStorage.h"

@interface VideoAPI()

@property (nonatomic,strong) VideoBiz *videoBiz;
@property (nonatomic,strong) VideoStorage *videoStorage;

@end

@implementation VideoAPI

- (void)getVideosWithCategory:(NSString *)category
                         page:(int)page
                        count:(int)count
{
  [self.videoBiz getVideosWithCategory:category page:page count:count];
}

- (void)videosWithCategory:(NSString *)category
{
  NSArray *result = nil;
  result = [self.videoBiz videosWithCategory:category];
  
  if ([category isEqual:classifications[0]]) {
    self.videoStorage.TVDramas = result;
  }
  else if ([category isEqualToString:classifications[1]]) {
    self.videoStorage.films = result;
  }
  else if ([category isEqualToString:classifications[2]]) {
    self.videoStorage.animations = result;
  }
  else if ([category isEqualToString:classifications[3]]) {
    self.videoStorage.zongs = result;
  }
  else if ([category isEqualToString:classifications[4]]) {
    self.videoStorage.funnys = result;
  }
  else if ([category isEqualToString:classifications[5]]) {
    self.videoStorage.infomations = result;
  }
  else if ([category isEqualToString:classifications[6]]) {
    self.videoStorage.creatives = result;
  }
  else if ([category isEqualToString:lives[0]]) {
    self.videoStorage.musics = result;
  }
  else if ([category isEqualToString:lives[1]]) {
    self.videoStorage.games = result;
  }
  else if ([category isEqualToString:lives[2]]) {
    self.videoStorage.sports = result;
  }
  else if ([category isEqualToString:lives[3]]) {
    self.videoStorage.educations = result;
  }
  else if ([category isEqualToString:lives[4]]) {
    self.videoStorage.sciences = result;
  }
  else if ([category isEqualToString:lives[5]]) {
    self.videoStorage.cars = result;
  }
}


- (VideoStorage *)videoStorage
{
  return GetInstance(VideoStorage, _videoStorage);
}

- (VideoBiz *)videoBiz
{
  return GetInstance(VideoBiz, _videoBiz);
}

@end
