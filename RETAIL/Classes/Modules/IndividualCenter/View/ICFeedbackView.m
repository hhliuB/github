//
//  ICFeedbackView.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ICFeedbackView.h"

// 意见反馈

@implementation ICFeedbackView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    float y = 20;
    
    [self addLabelWithFrame:CGRectMake(40, y, 400, 50) text:@"意见和反馈" textColor:kTextColor font:kLargestFont];
    y += 50;
    
    [self addViewWithFrame:CGRectMake(30, y, self.width - 50, 1) class:[UIView class] backgroundColor:kLineColor];
    y += 20;
    
    [self addLabelWithFrame:CGRectMake(40, y, 70, 40) text:@"内容描述:" textColor:kTextColor font:kLargerFont];
    _contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(120, y, 300, 100)];
    [_contentTextView addBorderWithColor:kLineColor width:1];
    _contentTextView.text = @"请详细描述您的问题、意见等";
    [_contentTextView setFont:kLargerFont];
    [_contentTextView setTextColor:kTextColor];

    [self addSubview:_contentTextView];
    y += 110;
    
    [self addLabelWithFrame:CGRectMake(40, y, 70, 40) text:@"我要举报:" textColor:kTextColor font:kLargerFont];
    _reportTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, y, 300, 40)];
    _reportTextField.borderStyle = UITextBorderStyleNone;
    [_reportTextField addBorderWithColor:kLineColor width:1];
    _reportTextField.placeholder = @"请详细描述您的问题、意见等";
    [_reportTextField setTextColor:kTextColor];
    [self addSubview:_reportTextField];
    y += 50;
    
    [self addLabelWithFrame:CGRectMake(40, y, 70, 40) text:@"联系方式:" textColor:kTextColor font:kLargerFont];
    _contactTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, y, 300, 40)];
    _contactTextField.borderStyle = UITextBorderStyleNone;
    [_contactTextField addBorderWithColor:kLineColor width:1];
    _contactTextField.placeholder = @"电话 \\ 邮箱 \\ QQ";
    [_contactTextField setTextColor:kTextColor];
    [self addSubview:_contactTextField];
    y += 50;
    
    [self addLabelWithFrame:CGRectMake(40, y, 70, 40) text:@"所在地:" textColor:kTextColor font:kLargerFont];
    _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, y, 300, 40)];
    _addressTextField.borderStyle = UITextBorderStyleNone;
    [_addressTextField addBorderWithColor:kLineColor width:1];
    [_addressTextField setTextColor:kTextColor];
    [self addSubview:_addressTextField];
    y += 50;
    
    _submitButton = [self addButtonWithFrame:CGRectMake((self.width - 200) / 2, y + 80, 200, 60)];
    [_submitButton.layer setCornerRadius:5];
    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_submitButton setTitleColor:kTextColor forState:UIControlStateNormal];
//    [_submitButton
//    [_submitButton addBorderWithColor:kLineColor width:2];
    [_submitButton.titleLabel setFont:kLargestFont];
    [_submitButton setBackgroundColor:kBlueColor];
    
  }
  return self;
}

@end
