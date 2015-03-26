
/******************************************************************************
 *  @file   : CellSelectedBackgroundView.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-10
 *  @brief  : 默认选中 cell 时的背景视图
 ******************************************************************************/

#import "CellSelectedBackgroundView.h"

@implementation CellSelectedBackgroundView

+ (instancetype)defaultViewWithFrame:(CGRect)frame
{
  CellSelectedBackgroundView *view = [[CellSelectedBackgroundView alloc] initWithFrame:frame];
  view.backgroundColor = kLightBlueColor;
  return view;
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGFloat r, g, b, a;
  [kDarkBlueColor getRed:&r green:&g blue:&b alpha:&a];
  CGContextSetRGBStrokeColor(context, r, g, b, a);
  
  CGContextSetLineWidth(context, 1);
  
  CGContextMoveToPoint(context, 0, 0);
  CGContextAddLineToPoint(context, 0, self.bounds.size.height);
  CGContextStrokePath(context);
}

@end
