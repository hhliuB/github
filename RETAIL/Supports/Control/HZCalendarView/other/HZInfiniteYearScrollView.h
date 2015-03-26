#import <UIKit/UIKit.h>

@class HZInfiniteYearScrollView;
@protocol InfiniteScrollViewDelegate <NSObject, UIScrollViewDelegate>

@required
- (void)infiniteScrollView:(HZInfiniteYearScrollView *)scrollView
           didScrollToYear:(int)year;

- (void)infiniteScrollView:(HZInfiniteYearScrollView *)scrollView
             didSelectYear:(int)year
                    offset:(CGPoint)offset;

@end


@interface HZInfiniteYearScrollView : UIScrollView

@property(nonatomic, strong) NSMutableArray *visibleLabels;

- (id)initWithFrame:(CGRect)frame year:(int)year;

@property(nonatomic,readwrite) NSInteger selectedYear;

@property(nonatomic,assign) id<InfiniteScrollViewDelegate> delegate;

@end
