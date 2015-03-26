
/******************************************************************************
 *  @file   : DCViewController+PopAndDismiss.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-10
 *  @brief  : 用于实现 提交动画 及 dismiss动画 的 DCViewController 扩展
 ******************************************************************************/

#import "DCViewController.h"

@interface DCViewController (PopAndDismiss)

- (void)dismiss;
- (void)dismiss:(void (^)())completion;

// 这两个 pop 方法有 bug，暂时禁用
- (void)popFromTop UNAVAILABLE_ATTRIBUTE;
- (void)popFromTop:(void (^)())completion UNAVAILABLE_ATTRIBUTE;

@end
