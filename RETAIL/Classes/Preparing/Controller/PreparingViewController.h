
/******************************************************************************
 *  @file   : PreparingViewController.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-10-31
 *  @brief  : 用于准备进入 App 时必要的数据，并执行相应的 UI 动画
 ******************************************************************************/

#import <UIKit/UIKit.h>

@interface PreparingViewController : UIViewController

@property (nonatomic,strong) UIImage *logo;

- (void)attachImage:(UIImage *)image on:(CGPoint)topLeft;

- (void)setProgress:(float)progress;
- (void)setMessage:(NSString *)message;

+ (instancetype)getInstance;

@end
