
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewReloadAnimationDirection) {
  UIViewReloadAnimationDirectionNone,
  UIViewReloadAnimationDirectionTop,
  UIViewReloadAnimationDirectionBottom,
  UIViewReloadAnimationDirectionLeft,
  UIViewReloadAnimationDirectionRight
};

@interface UIView (AnimationShortcuts)

- (void)moveX:(CGFloat)x;
- (void)moveY:(CGFloat)y;
- (void)moveX:(CGFloat)x completion:(void (^)())completion;
- (void)moveY:(CGFloat)y completion:(void (^)())completion;

- (void)setX:(CGFloat)x completion:(void (^)())completion;
- (void)setY:(CGFloat)y completion:(void (^)())completion;

- (void)fadeout:(void (^)())completion;
- (void)fadein:(void (^)())completion;

- (void)changeFrameTo:(CGRect)frame
           completion:(void (^)())completion;

- (void)reloadWithAnimationDirection:(UIViewReloadAnimationDirection)animationDirection
                     reloadDataBlock:(void (^)())reloadDataBlock
                          completion:(void (^)())completion;

- (void)reloadWithAnimationDirection:(UIViewReloadAnimationDirection)animationDirection
                              offset:(CGFloat)offset
                     reloadDataBlock:(void (^)())reloadDataBlock
                          completion:(void (^)())completion;


@end
