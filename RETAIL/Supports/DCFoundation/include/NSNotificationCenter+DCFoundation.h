
#import <Foundation/Foundation.h>

@interface NSNotificationCenter (DCFoundation)

#if NS_BLOCKS_AVAILABLE
/**
 *  简化的 addObserverForName:object:queue:usingBlock: 方法。
 *  注意：使用此方法接收的通知，block方法中对事件的处理所在线程与通知发出时其所在线程相同，且于其线程中同步执行
 *
 *  @param name  通知名称
 *  @param block 接收到通知时的执行的代码
 *
 *  @return 充当观察者的对象，用于调用 removeObserver: 方法以注销
 */

- (id)addObserverForName:(NSString *)name usingBlock:(void (^)(NSNotification *noti))block;
#endif

@end
