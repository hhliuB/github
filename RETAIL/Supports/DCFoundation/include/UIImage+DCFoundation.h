
#import <UIKit/UIKit.h>

@interface UIImage (DCFoundation)

+ (UIImage *)imageWithBase64String:(NSString *)base64String;

+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)imageWithName:(NSString *)name type:(NSString *)type;

@end

@interface UIImage (UNAVAILABLE_FUNCTIONS)

+ (UIImage *)imageNamed:(NSString *)name UNAVAILABLE_ATTRIBUTE;

@end
