//
//  WorkEntities.h
//  RETAIL
//
//  Created by Duke Cui on 15/1/29.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "SFAObject.h"

@class Terminal;

typedef NS_ENUM(NSInteger, CallStatus) {
  CallStatusPlan,
  CallStatusCompleted,
  CallStatusExpired
};

typedef NS_ENUM(NSInteger, CallType) {
  CallTypeNormal,
  CallTypeNoPlan
};

@interface Call : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *ampmString;
@property (copy) NSString *timeString;
@property (copy) NSString *durationString;
@property (copy) NSString *terminalId;

@property (assign) CallStatus status;
@property (assign) CallType   type;

@property (strong) Terminal *terminal;

@end

typedef NS_ENUM(NSInteger, TaskStatus) {
  TaskStatusNormal,
  TaskStatusCompleted,
  TaskStatusExpired,
};

@interface Task : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *name;
@property (copy) NSString *terminalId;
@property (copy) NSString *timeString;

@property (assign) TaskStatus status;

@property (strong) Terminal *terminal;

@end

@interface Route : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *name;

@property (assign) NSInteger terminalCount;
@property (assign) NSInteger kilometre;

@end
