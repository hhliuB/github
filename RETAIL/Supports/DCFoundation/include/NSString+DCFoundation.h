
/*
 需要引用的库：
 |- CoreFoundation.framework
 */

#import <Foundation/Foundation.h>

@interface NSString (DCFoundation)

- (NSString *)md5;
- (NSString *)pinyin;

@end
