//
//  DCTableViewProxy.h
//  DCTableView
//
//  Created by Duke on 13-11-13.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCTableViewProxy : NSObject

@property(nonatomic) id delegate;
@property(nonatomic) id dataSource;
@property(nonatomic) id middleMan;

@end
