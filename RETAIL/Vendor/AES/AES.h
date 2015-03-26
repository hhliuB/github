
#import <Foundation/Foundation.h>

@interface AES : NSObject

+ (AES *)AES128;
+ (AES *)AES192;
+ (AES *)AES256;

- (NSString *)encryptString:(NSString *)string withKey:(NSString *)key;
- (NSString *)decryptString:(NSString *)string withKey:(NSString *)key;

- (NSData *)encrypteData:(NSData *)data withKey:(NSString *)key;
- (NSData *)decrypteData:(NSData *)data withKey:(NSString *)key;

- (BOOL)encryptFile:(NSString *)inPath
             toFile:(NSString *)outPath
            withKey:(NSString *)key
              error:(NSError **)error;

- (BOOL)decryptFile:(NSString *)inPath
             toFile:(NSString *)outPath
            withKey:(NSString *)key
              error:(NSError **)error;

@end
