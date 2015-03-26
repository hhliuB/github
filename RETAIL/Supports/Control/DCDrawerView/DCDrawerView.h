
#import <UIKit/UIKit.h>

#ifndef __Direction_Enumerate__
#define __Direction_Enumerate__
typedef NS_ENUM(NSInteger, Direction) {
  DirectionUnknown,
  DirectionTop,
  DirectionBottom,
  DirectionLeft,
  DirectionRight
};
#endif

@protocol DCDrawerViewDelegate;

@interface DCDrawerView : UIView

@property(nonatomic,weak) id<DCDrawerViewDelegate> delegate;

@property(nonatomic,assign) CGFloat maxSlideDistance;   // Default is 100.0.
@property(nonatomic,assign) BOOL    allowsSlideToLeft;  // Default is NO.
@property(nonatomic,assign) BOOL    allowsSlideToRight; // Default is NO.

@property(nonatomic,readonly) UIView *contentView;
@property(nonatomic,readonly) UIView *foregroundView;
@property(nonatomic,readonly) UIView *backgroundView;

@property(nonatomic,assign) NSTimeInterval openAnimationBaseDuration;         // Default is 0.3.
@property(nonatomic,assign) NSTimeInterval closeAnimationBaseDuration;        // Default is 0.3.
@property(nonatomic,assign) NSTimeInterval resetContentAnimationBaseDuration; // Default is 0.3.

- (void)openAnimated:(BOOL)animated
         toDirection:(Direction)toDirection
          completion:(void (^)())completion;

- (void)closeAnimated:(BOOL)animated completion:(void (^)())completion;

@end

@protocol DCDrawerViewDelegate <NSObject>

@optional

- (BOOL)drawerViewShouldBeginDragging:(DCDrawerView *)drawerView;
- (void)drawerViewDidBeginDragging:(DCDrawerView *)drawerView;
- (void)drawerViewDidEndDragging:(DCDrawerView *)drawerView;

- (void)drawerViewDidAbortDragging:(DCDrawerView *)drawerView;

@end
