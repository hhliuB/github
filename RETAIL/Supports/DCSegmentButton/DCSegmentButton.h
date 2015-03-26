#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DCSegmentButtonStyle) {
  DCSegmentButtonStyleRoundRect,
  DCSegmentButtonStylePlainText
};

@protocol DCSegmentButtonDelegate;

@interface DCSegmentButton : UIView

@property(nonatomic) id<DCSegmentButtonDelegate> delegate;
@property(nonatomic) NSInteger selectedIndex;

@property(nonatomic) UIColor *borderColor;

// 当 style == DCSegmentButtonStylePlainText 时，控件宽度自动适配
- (id)initWithFrame:(CGRect)frame
              style:(DCSegmentButtonStyle)style
             titles:(NSArray *)titles;

- (void)setTitleColor:(UIColor *)color
             forState:(UIControlState)state;

// 当 style == DCSegmentButtonStylePlainText 时，此方法无效果
- (void)setButtonBackgroundImage:(UIImage *)image
                        forState:(UIControlState)state;

@end

@protocol DCSegmentButtonDelegate <NSObject>

@required
- (void)segmentButton:(DCSegmentButton *)segmentButton
       didSelectIndex:(NSInteger)index;

@end
