//
//  UserViewModel.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCViewModel.h"

#import "Entities.h"

@interface UserViewModel : DCViewModel

@property (nonatomic,readonly) User *me;

@end
