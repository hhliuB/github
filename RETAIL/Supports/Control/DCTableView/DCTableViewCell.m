//
//  DCTableViewCell.m
//  DCTableView
//
//  Created by Duke on 13-9-12.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCTableViewCell.h"

#import "DCDrawerView.h"

static UIViewAutoresizing g_autoresizingFlexibleSize =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

@interface DCTableViewCell ()
<DCDrawerViewDelegate>

@property (nonatomic,strong) DCDrawerView *drawerView;

@end

@implementation DCTableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (self) {
    self.clipsToBounds = YES;
    
    UIView *contentView = self.contentView;
    
    _drawerView = [[DCDrawerView alloc] initWithFrame:contentView.bounds];
    _drawerView.delegate = self;
    _drawerView.autoresizingMask = g_autoresizingFlexibleSize;
    [contentView addSubview:_drawerView];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
}

- (void)closeAnimated:(BOOL)animated
{
  [self.drawerView closeAnimated:animated completion:nil];
}

- (void)addActionButton:(UIButton *)button
{
  [button addTarget:self
             action:@selector(actionButtonDidPress:)
      forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionButtonDidPress:(UIButton *)button
{
  if ([self.delegate respondsToSelector:@selector(cell:actionButtonDidPress:)]) {
    [self.delegate cell:self actionButtonDidPress:button];
  }
}

#pragma mark -
#pragma mark Properties

- (UIView *)foreView
{
  return self.drawerView.foregroundView;
}

- (UIView *)backContentView
{
  return self.drawerView.backgroundView;
}

- (UIView *)foreContentView
{
  return self.drawerView.contentView;
}

#pragma mark -
#pragma mark DCDrawerView Delegate

- (BOOL)drawerViewShouldBeginDragging:(DCDrawerView *)drawerView
{
  if ([self.delegate respondsToSelector:@selector(cellShouldBeginDragging:)]) {
    return [self.delegate cellShouldBeginDragging:self];
  }
  return YES;
}

- (void)drawerViewDidBeginDragging:(DCDrawerView *)drawerView {
  if ([self.delegate respondsToSelector:@selector(cellDidBeginDragging:)]) {
    [self.delegate cellDidBeginDragging:self];
  }
}

- (void)drawerViewDidEndDragging:(DCDrawerView *)drawerView {
  if ([self.delegate respondsToSelector:@selector(cellDidEndDragging:)]) {
    [self.delegate cellDidEndDragging:self];
  }
}

- (void)drawerViewDidAbortDragging:(DCDrawerView *)drawerView
{
  if ([self.delegate respondsToSelector:@selector(cellDidAbortDragging:)]) {
    [self.delegate cellDidAbortDragging:self];
  }
}


#pragma mark -
#pragma mark ForwardInvocation

- (void)forwardInvocation:(NSInvocation*)invocation
{
	SEL selector = [invocation selector];
  
	if ([self.drawerView respondsToSelector:selector]) {
		[invocation invokeWithTarget:self.drawerView];
	}
	else {
		[self doesNotRecognizeSelector:selector];
	}
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
	NSMethodSignature* methodSignature = [super methodSignatureForSelector:selector];
	if (methodSignature == nil) {
		methodSignature = [self.drawerView methodSignatureForSelector:selector];
	}
  
	return methodSignature;
}

- (BOOL)respondsToSelector:(SEL)selector
{
	return [super respondsToSelector:selector] || [self.drawerView respondsToSelector:selector];
}

@end
