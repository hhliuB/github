//
//  DCInputView.m
//  DCInputView
//
//  Created by Duke on 13-12-9.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCInputView.h"

#define kDefaultAnimationDuration 0.25

@interface DCInputView ()
<UITextFieldDelegate>
{
  UILabel *_titleLabel;
}

@end

@implementation DCInputView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat w = CGRectGetWidth(frame);
    CGFloat h = CGRectGetHeight(frame);
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 20)];
    _titleLabel.center = CGPointMake(w / 2, h / 2);
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, w - 150, 20)];
    _textField.center = CGPointMake(w / 2, h / 2);
    _textField.backgroundColor = [UIColor clearColor];
    _textField.delegate = self;
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:_textField];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGFloat w = CGRectGetWidth(self.bounds);
  CGFloat h = CGRectGetHeight(self.bounds);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
  CGContextSetLineWidth(context, 1.0);
  CGContextMoveToPoint(context, 0.0, h - 1);
  CGContextAddLineToPoint(context, w, h - 1);
  CGContextStrokePath(context);
}


- (BOOL)becomeFirstResponder {
  return [_textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
  [_textField resignFirstResponder];
  return [super resignFirstResponder];
}

- (void)setTitle:(NSString *)title {
  _title = title;
  _titleLabel.text = _title;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
  _secureTextEntry = secureTextEntry;
  _textField.secureTextEntry = _secureTextEntry;
}

- (NSString *)text {
  return _textField.text;
}

- (void)setText:(NSString *)text {
  CGFloat x, y;
  if (text.length == 0) {
    x = self.bounds.size.width / 2;
    y = self.bounds.size.height / 2;
  }
  else {
    x = _titleLabel.bounds.size.width / 2;
    y = self.bounds.size.height / 2;
  }
  
  _titleLabel.center = CGPointMake(x, y);
  _textField.text = text;
}

- (void)setFont:(UIFont *)font
{
  _font = font;
  _titleLabel.font = _font;
  _textField.font = _font;
}

- (void)setTintColor:(UIColor *)tintColor
{
  _tintColor = tintColor;
  _titleLabel.textColor = _tintColor;
  _textField.textColor = _tintColor;
}

- (void)setEnabled:(BOOL)enabled
{
  _enabled = enabled;
  _textField.enabled = _enabled;
}

#pragma mark -

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  CGRect labelFrame = _titleLabel.frame;
  labelFrame.origin.x = 0;
  
  [UIView animateWithDuration:kDefaultAnimationDuration
                   animations:^{
                     _titleLabel.frame = labelFrame;
                   }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  return [_delegate inputViewShouldReturn:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  if (textField.text.length == 0) {
    CGRect labelFrame = _titleLabel.frame;
    labelFrame.origin.x = (self.frame.size.width - labelFrame.size.width) / 2;
    
    [UIView animateWithDuration:kDefaultAnimationDuration
                     animations:^{
                       _titleLabel.frame = labelFrame;
                     }];
  }
}


@end
