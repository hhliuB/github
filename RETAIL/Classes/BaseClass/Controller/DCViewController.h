
/******************************************************************************
 *  @file   : DCViewController.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-10
 *  @brief  : 视图控制器基类
 ******************************************************************************/

#import <Foundation/Foundation.h>

#import "DCView.h"

#define AddView(instance, class, frame)  ({                                                       \
                                            (instance) = [[(class) alloc] initWithFrame:(frame)]; \
                                            [self.view addSubview:(instance)];                    \
                                          })

@interface DCViewController : UIViewController

@property (nonatomic,strong) DCView *view;;

- (Class)viewClass;
- (CGRect)viewFrame;
- (CGRect)viewFrameForChildViewController:(DCViewController *)child;

@end

@interface DCViewController (BaseViewGestureAdditions)

- (BOOL)allowsPop;

@end

@interface DCViewController (LoadingIndicator)

- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;

@end

@interface DCViewController (PushAdditions)

- (void)didPopBack;

@end

@interface DCViewController (PresentAdditions)

- (void)didDismissBack;

@end
