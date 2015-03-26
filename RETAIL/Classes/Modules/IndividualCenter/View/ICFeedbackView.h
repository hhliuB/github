//
//  ICFeedbackView.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCView.h"

@interface ICFeedbackView : DCView

@property (nonatomic,readonly) UITextView  *contentTextView;
@property (nonatomic,readonly) UITextField *reportTextField;
@property (nonatomic,readonly) UITextField *addressTextField;
@property (nonatomic,readonly) UITextField *contactTextField;

@property (nonatomic,readonly) UIButton *submitButton;

@end
