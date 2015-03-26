
#import "AES.h"

#import "Base64.h"
#import "NSData-AES.h"
#import "NSFileManager-AES.h"

typedef NS_ENUM(NSInteger, KEYBITS) {
  KEYBITS128 = 128,
  KEYBITS192 = 192,
  KEYBITS256 = 256,
};

@interface AES ()

@property (nonatomic) KEYBITS keybits;

@end

@implementation AES

+ (AES *)AES128
{
  AES *aes = [[AES alloc] init];
  aes.keybits = KEYBITS128;
  return aes;
}

+ (AES *)AES192
{
  AES *aes = [[AES alloc] init];
  aes.keybits = KEYBITS192;
  return aes;
}

+ (AES *)AES256
{
  AES *aes = [[AES alloc] init];
  aes.keybits = KEYBITS256;
  return aes;
}

- (NSString *)encryptString:(NSString *)string withKey:(NSString *)key
{
  [Base64 initialize];
  
  NSData *data          = [string dataUsingEncoding:NSUTF8StringEncoding];
  NSData *encryptedData = [data AESEncryptWithPassphrase:key keybits:self.keybits];
  
  return [Base64 encode:encryptedData];
}

- (NSString *)decryptString:(NSString *)string withKey:(NSString *)key
{
  [Base64 initialize];
  
  NSData *encryptedData = [Base64 decode:string];
  NSData *decryptedData = [encryptedData AESDecryptWithPassphrase:key keybits:self.keybits];
  
  NSString *decryptedString = [[NSString alloc] initWithData:decryptedData
                                                    encoding:NSUTF8StringEncoding];
  return decryptedString;
}

- (NSData *)encrypteData:(NSData *)data withKey:(NSString *)key
{
  return [data AESEncryptWithPassphrase:key keybits:self.keybits];
}

- (NSData *)decrypteData:(NSData *)data withKey:(NSString *)key
{
  return [data AESDecryptWithPassphrase:key keybits:self.keybits];
}

- (BOOL)encryptFile:(NSString *)inPath
             toFile:(NSString *)outPath
            withKey:(NSString *)key
              error:(NSError **)error
{
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  return [fileMgr AESEncryptFile:inPath
                          toFile:outPath
                 usingPassphrase:key
                         keybits:self.keybits
                           error:error];
}

- (BOOL)decryptFile:(NSString *)inPath
             toFile:(NSString *)outPath
            withKey:(NSString *)key
              error:(NSError **)error
{
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  return [fileMgr AESDecryptFile:inPath
                          toFile:outPath
                 usingPassphrase:key
                         keybits:self.keybits
                           error:error];
}

@end
