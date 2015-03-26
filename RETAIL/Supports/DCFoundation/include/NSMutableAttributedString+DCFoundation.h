
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (DCFoundation)

- (void)addAttributedWithString:(NSString *)string
                          color:(UIColor *)color;

- (void)addAttributedWithString:(NSString *)string
                           font:(UIFont *)font
                          color:(UIColor *)color;

@end
