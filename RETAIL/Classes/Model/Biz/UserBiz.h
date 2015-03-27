//
//  UserBiz.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "Biz.h"

#import "Entities.h"

@interface UserBiz : Biz

@property (nonatomic,readonly) User *me;

- (void)getUserDetailedInformation;
- (void)selectUserInformation;

@end
