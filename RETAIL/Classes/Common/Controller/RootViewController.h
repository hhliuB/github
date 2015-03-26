/******************************************************************************
 *  @file   : RootViewController.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-12
 *  @brief  : 负责布局 MainViewController 和 PreparingViewController，
 *            以及获取主数据
 ******************************************************************************/

#import "DCViewController.h"

@interface RootViewController : DCViewController

- (void)enter;
- (void)reloadEssentialData;

+ (instancetype)getInstance;

@end

