
/******************************************************************************
 *  @file   : DCView.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-10
 *  @brief  : 视图基类
 ******************************************************************************/

#import <UIKit/UIKit.h>

#define kDCViewCoverDidTapNotification        @"kDCViewCoverDidTapNotification"
#define kDCViewCoverDidSwipeLeftNotification  @"kDCViewCoverDidSwipeLeftNotification"
#define kDCViewCoverDidSwipeRightNotification @"kDCViewCoverDidSwipeRightNotification"

@interface DCView : UIView

- (void)fadeInCover;
- (void)fadeOutCover;

- (void)fadeInCoverCompletion:(void (^)())completion;
- (void)fadeOutCoverCompletion:(void (^)())completion;

- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;

@end
