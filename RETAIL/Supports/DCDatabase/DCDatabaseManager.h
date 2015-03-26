
#import <Foundation/Foundation.h>

#import "DCDatabase.h"

@interface DCDatabaseManager : NSObject

/**
 *  单例模式获取 DCDatabaseManager 实例
 */
+ (instancetype)sharedManager;

/**
 *  获取指定 identifier 的 DCDatabase 实例。
 *  并在 shouldEncryptDatabase 为 YES 时，使用 key 对数据库进行加密。
 *  若调用此方法时尚未创建相应的 database，则自动创建并打开
 */
- (DCDatabase *)database:(NSString *)identifier withKey:(NSString *)key;

/**
 *  关闭指定 identifier 的 DCDatabase
 */
- (void)closeDatabase:(NSString *)identifier;

/**
 *  数据库文件保存的目录。默认是 App 对应的 Documents 目录
 */
@property (nonatomic,copy) NSString *directory;

@property (nonatomic) BOOL shouldEncryptDatabase;

@end
