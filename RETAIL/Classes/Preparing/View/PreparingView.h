
/******************************************************************************
 *  @file   : PreparingView.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-10-31
 *  @brief  : 准备进入 App 时获取数据过程中显示的视图
 *            服务于 PreparingViewController
 ******************************************************************************/

#import "DCView.h"

@interface PreparingView : DCView

@property (nonatomic,strong) UIImage  *logo;
@property (nonatomic,copy)   NSString *message;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
