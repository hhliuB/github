//
//  DCTableView.h
//  DCTableView
//
//  Created by Duke on 13-9-12.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCTableViewCell.h"

@class DCTableView;

@protocol DCTableViewDataSource <NSObject, UITableViewDataSource>

@optional

- (BOOL)tableView:(DCTableView *)tableView shouldSlideCellToLeftAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(DCTableView *)tableView shouldSlideCellToRightAtIndexPath:(NSIndexPath *)indexPath;

@end


@protocol DCTableViewDelegate <NSObject, UITableViewDelegate>

@optional
- (void)tableView:(DCTableView *)tableView
    didPressActionButton:(UIButton *)button
             atIndexPath:(NSIndexPath *)indexPath;

@end


@interface DCTableView : UITableView

- (id)initWithFrame:(CGRect)frame;

@property(nonatomic,assign) id<DCTableViewDataSource> dataSource;
@property(nonatomic,assign) id<DCTableViewDelegate> delegate;

@end

@interface DCTableView (Unavailable)

- (id)init UNAVAILABLE_ATTRIBUTE;
- (id)initWithCoder:(NSCoder *)aDecoder UNAVAILABLE_ATTRIBUTE;
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style UNAVAILABLE_ATTRIBUTE;

@end
