//
//  MainDatabaseOperation.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/25.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "BizDatabaseOperation.h"

#import "SysEntities.h"

@interface MainDatabaseOperation : BizDatabaseOperation

- (NSString *)configValueForKey:(NSString *)key;
- (Config *)configForKey:(NSString *)key;

@end
