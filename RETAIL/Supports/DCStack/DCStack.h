#import <Foundation/Foundation.h>

@interface DCStack : NSObject

- (instancetype)init;
+ (instancetype)stack;

- (void)push:(id)object;
- (id)pop;

- (id)top;
- (id)bottom;

- (BOOL)contains:(id)object;

- (void)clear;

- (void)enumerateObjectsUsingBlock:(void (^)(id obj, BOOL *stop))block;

@property (nonatomic,readonly) NSUInteger length;
@property (nonatomic,readonly) BOOL       isEmpty;

@end
