
#import <UIKit/UIKit.h>

@interface UIColor (DCFoundation)

/**
 *  r, g, b 范围 [0, 255]
 */
+ (UIColor *)colorWithRedValue:(CGFloat)r greenValue:(CGFloat)g blueValue:(CGFloat)b;

/**
 *  r, g, b 范围 [0, 255], a 范围 [0, 1]
 */
+ (UIColor *)colorWithRedValue:(CGFloat)r greenValue:(CGFloat)g blueValue:(CGFloat)b alphaValue:(CGFloat)a;

/**
 *  hex 范围 [0x000000, 0xFFFFFF]
 */
+ (UIColor *)colorWithHex:(NSInteger)hex;

/**
 *  hex 范围 [0x000000, 0xFFFFFF], alpha 范围 [0, 1]
 */
+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

/**
 *  rgb 范围 [0, 255]
 */
+ (UIColor *)grayColorWithRGBValue:(CGFloat)rgb;

/**
 *  rgb 范围 [0, 255], alpha 范围 [0, 1]
 */
+ (UIColor *)grayColorWithRGBValue:(CGFloat)rgb alpha:(CGFloat)alpha;

@end
