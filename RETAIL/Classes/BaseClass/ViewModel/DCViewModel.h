
/******************************************************************************
 *  @file   : DCViewModel.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-12-05
 *  @brief  : 视图模型（ViewModel）基类
 ******************************************************************************/

#import <Foundation/Foundation.h>

@interface DCViewModel : NSObject

- (void)loadData:(void (^)())completion;

@end
