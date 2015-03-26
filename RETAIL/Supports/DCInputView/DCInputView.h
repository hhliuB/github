//
//  DCInputView.h
//  DCInputView
//
//  Created by Duke on 13-12-9.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCInputViewDelegate;

@interface DCInputView : UIView

@property(nonatomic,weak) id<DCInputViewDelegate> delegate;

@property(nonatomic,readonly) UITextField *textField;
@property(nonatomic) NSString *title;
@property(nonatomic) NSString *text;
@property(nonatomic) BOOL      secureTextEntry;

@property(nonatomic) UIFont   *font;      // Default is [UIFont systemFontOfSize:15.0]
@property(nonatomic) UIColor  *tintColor; // Default is [UIColor whiteColor]

@property(nonatomic,getter=isEnabled) BOOL enabled; // Default is YES

- (id)initWithFrame:(CGRect)frame; // 宽度最小150，高度最小50

- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;

@end

@protocol DCInputViewDelegate <NSObject>

@required
- (BOOL)inputViewShouldReturn:(DCInputView *)inputView;

@end

