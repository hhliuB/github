
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (DCFoundation)

+ (NSAttributedString *)attributedWithString:(NSString *)string
                                   alignment:(NSTextAlignment)alignment
                                        font:(UIFont *)font
                                       color:(UIColor *)color;

+ (NSAttributedString *)attributedWithString:(NSString *)string
                                       color:(UIColor *)color;

+ (NSAttributedString *)attributedWithString:(NSString *)string
                                        font:(UIFont *)font
                                       color:(UIColor *)color;

@end
