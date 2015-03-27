//
//  VideoBiz.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/26.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "Biz.h"

@interface VideoBiz : Biz

- (void)getVideosWithCategory:(NSString *)category
                         page:(int)page
                        count:(int)count;
- (NSArray *)videosWithCategory:(NSString *)category;
@end
