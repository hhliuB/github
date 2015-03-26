//
//  DCTableViewCell.h
//  DCTableView
//
//  Created by Duke on 13-9-12.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCTableViewCellDelegate;

@interface DCTableViewCell : UITableViewCell

@property(nonatomic,weak) id<DCTableViewCellDelegate> delegate;

@property(nonatomic,readonly) UIView *foreView;
@property(nonatomic,readonly) UIView *backContentView;
@property(nonatomic,readonly) UIView *foreContentView;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)closeAnimated:(BOOL)animated;

- (void)addActionButton:(UIButton *)button;

@end

@interface DCTableViewCell (ForwardInvocation)

@property(nonatomic,assign) CGFloat maxSlideDistance;   // Default is 100.0.
@property(nonatomic,assign) BOOL    allowsSlideToLeft;  // Default is NO.
@property(nonatomic,assign) BOOL    allowsSlideToRight; // Default is NO.

@end

@protocol DCTableViewCellDelegate <NSObject>

@required
- (void)cell:(DCTableViewCell *)cell actionButtonDidPress:(UIButton *)button;

@optional
- (BOOL)cellShouldBeginDragging:(DCTableViewCell *)cell;
- (void)cellDidBeginDragging:(DCTableViewCell *)cell;
- (void)cellDidEndDragging:(DCTableViewCell *)cell;
- (void)cellDidAbortDragging:(DCTableViewCell *)cell;

@end


@interface DCTableViewCell (Deprecated_Nonfunctional)

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier UNAVAILABLE_ATTRIBUTE;

@end
