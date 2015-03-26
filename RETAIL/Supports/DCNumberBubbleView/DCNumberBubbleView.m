//
//  DCNumberBubbleView.m
//  DCNumberBubbleView
//
//  Created by Duke on 13-12-11.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "DCNumberBubbleView.h"

@implementation DCNumberBubbleView
{
  UILabel *_numberLabel;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _bubbleColor   = [UIColor redColor];
    _numberColor   = [UIColor whiteColor];
    _font          = [UIFont systemFontOfSize:15];
    _hidesWhenZero = YES;
    
    _numberLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _numberLabel.textColor        = _numberColor;
    _numberLabel.textAlignment    = NSTextAlignmentCenter;
    _numberLabel.font             = _font;
    _numberLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_numberLabel];
  }
  return self;
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGFloat r, g, b, a;
  
  [_bubbleColor getRed:&r green:&g blue:&b alpha:&a];
  
  CGContextSetRGBFillColor(context, r, g, b, a);
  
  CGContextFillEllipseInRect(context, self.bounds);
}

- (void)setFrame:(CGRect)frame
{
  [super setFrame:frame];
  [self setNeedsDisplay];
}

- (void)setBubbleColor:(UIColor *)bubbleColor
{
  _bubbleColor = bubbleColor;
  [self setNeedsDisplay];
}

- (void)setNumberColor:(UIColor *)numberColor
{
  _numberColor = numberColor;
  _numberLabel.textColor = _numberColor;
}

- (void)setFont:(UIFont *)font
{
  _font = font;
  _numberLabel.font = _font;
}

- (void)setNumber:(NSInteger)number
{
  _number = number;
  _numberLabel.text = [NSString stringWithFormat:@"%d", _number];
  if (_number == 0) {
    self.hidden = _hidesWhenZero;
  }
  else {
    self.hidden = NO;
  }
}

- (void)setHidesWhenZero:(BOOL)hidesWhenZero
{
  _hidesWhenZero = hidesWhenZero;
  if (_number == 0) {
    self.hidden = _hidesWhenZero;
  }
}

- (void)setAdjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth
{
  _adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
  _numberLabel.adjustsFontSizeToFitWidth = _adjustsFontSizeToFitWidth;
}

@end
