
/******************************************************************************
 *  @file   : PreparingView.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-10-31
 *  @brief  : 准备进入 App 时获取数据过程中显示的视图
 *            服务于 PreparingViewController
 ******************************************************************************/

#import "PreparingView.h"

/**
 *  407, 279
 */

@interface PreparingView ()

@property (nonatomic,strong) UIImageView    *logoView;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) UILabel        *messageLabel;

@end

@implementation PreparingView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self) {
    CGFloat x = CGRectGetMidX(frame);
    CGFloat y = CGRectGetMidY(frame) - 100;

    _logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 210, 210)];
    _logoView.center = CGPointMake(x, y);
    [self addSubview:_logoView];
    
    y += 120;
    
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1024, 20)];
    _messageLabel.center          = CGPointMake(x, y);
    _messageLabel.backgroundColor = [UIColor clearColor];
    _messageLabel.textColor       = [UIColor whiteColor];
    _messageLabel.textAlignment   = NSTextAlignmentCenter;
    [self addSubview:_messageLabel];
    
    y += 20;
    
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    _progressView.frame             = CGRectMake(0, 0, 150, 3);
    _progressView.center            = CGPointMake(x, y);
    _progressView.progressTintColor = [UIColor whiteColor];
    _progressView.trackTintColor    = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self addSubview:_progressView];
  }
  
  return self;
}

- (void)setLogo:(UIImage *)logo
{
  _logo = logo;
  self.logoView.image = logo;
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
  [self.progressView setProgress:progress animated:animated];
}

- (void)setMessage:(NSString *)message
{
  _message = message;
  self.messageLabel.text = message;
}

@end
