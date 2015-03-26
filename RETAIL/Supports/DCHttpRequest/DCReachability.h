//
//  DCReachability.h
//  DCHttpRequest
//
//  Created by Duke on 14-7-24.
//  Copyright (c) 2014年 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCReachability : NSObject

- (void)startMonitoring;
- (void)stopMonitoring;

- (BOOL)isReachable;
- (BOOL)isReachableViaWiFi;
- (BOOL)isReachableViaWWAN;

@property (atomic,copy) void(^reachabilityStatusDidChangeToUnknownBlock)();
@property (atomic,copy) void(^reachabilityStatusDidChangeToWiFiBlock)();
@property (atomic,copy) void(^reachabilityStatusDidChangeToWWANBlock)();
@property (atomic,copy) void(^reachabilityStatusDidChangeToNotReachableBlock)();

+ (instancetype)getInstance;

@end
