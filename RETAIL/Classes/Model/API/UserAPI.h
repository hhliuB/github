//
//  UserAPI.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "API.h"

#import "Entities.h"

@interface UserAPI : API

@property (nonatomic,readonly) User *me;

- (void)getUserDetailedInformation;
- (void)selectUserInformation;

@end
