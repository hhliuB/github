#import <Foundation/Foundation.h>

@interface NSString (HttpRequestAdditions)

- (NSString*)URLEncode;

- (NSString *)urlCombineWithParams:(id)params;

@end
