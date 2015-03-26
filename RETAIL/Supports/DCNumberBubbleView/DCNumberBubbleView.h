//
//  DCNumberBubbleView.h
//  DCNumberBubbleView
//
//  Created by Duke on 13-12-11.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCNumberBubbleView : UIView

- (id)initWithFrame:(CGRect)frame;

@property(nonatomic) UIColor   *bubbleColor; // Default is [UIColor redColor]
@property(nonatomic) UIColor   *numberColor; // Default is [UIColor whiteColor]
@property(nonatomic) UIFont    *font;        // Default is [UIFont systemFontOfSize:15]
@property(nonatomic) NSInteger  number;
@property(nonatomic) BOOL       adjustsFontSizeToFitWidth;

@property(nonatomic) BOOL hidesWhenZero; // Default is YES

@end
