//
//  MainDatabaseOperation.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "BizDatabaseOperation.h"

@interface MainDatabaseOperation : BizDatabaseOperation

- (void)getUserDetailedInformation:(void (^)())completion;
- (void)getVideos:(void (^)())completion;

@end
