//
//  VideoAPI.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/26.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "API.h"

@interface VideoAPI : API

- (void)getVideosWithCategory:(NSString *)category
                         page:(int)page
                        count:(int)count;
- (void)videosWithCategory:(NSString *)category;

@end
