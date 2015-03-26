//
//  UserBizOperation.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "BizNetworkOperation.h"

@interface UserBizOperation : BizNetworkOperation

- (void)getUserDetailedInformation:(void (^)())completion;

@end
