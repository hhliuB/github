//
//  MainDatabaseOperation.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "BizDatabaseOperation.h"

@interface MainDatabaseOperation : BizDatabaseOperation

- (void)getUserDetailedInformationWithUser:(NSString *)client_id
                              access_token:(NSString *)access_token;
- (void)getVideosWithCategory:(NSString *)category
                         page:(int)page
                        count:(int)count;
@end
