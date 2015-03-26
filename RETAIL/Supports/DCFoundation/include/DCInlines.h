
#import <UIKit/UIKit.h>

#ifndef DCFoundation_DCInlines_h
#define DCFoundation_DCInlines_h

NS_INLINE NSString * AppVersion() {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

NS_INLINE NSString * AppIdentifier() {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

NS_INLINE NSString * UUID() {
  CFUUIDRef uuidObj = CFUUIDCreate(nil);
  NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
  CFRelease(uuidObj);
  return [uuidString lowercaseString];
}

NS_INLINE NSString * DeviceType() {
  return [[UIDevice currentDevice] model];
}

NS_INLINE NSString * DeviceOS() {
  return [[UIDevice currentDevice] systemName];
}

NS_INLINE NSString * DeviceOSVersion() {
  return [[UIDevice currentDevice] systemVersion];
}

NS_INLINE NSString * CachesDirectory() {
  return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

NS_INLINE NSString * DocumentsDirectory() {
  return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

NS_INLINE NSString * DocumentsPathOfFile(NSString *file) {
  return [DocumentsDirectory() stringByAppendingPathComponent:file];
}

#define kAry 1000
NS_INLINE NSString *SizeStringForBytes(double bytes)
{
  NSString *s[] = {@"B", @"K", @"M", @"G"};
  int i = 0;
  while (bytes > kAry) {
    bytes /= kAry;
    i++;
  }
  
  return [NSString stringWithFormat:@"%.2f %@", bytes, s[i]];
}

/**
 *  使用最小值和最大值创建NSRange
 *
 *  @param min 最小值
 *  @param max 最大值
 *
 *  @return NSRange
 */
NS_INLINE NSRange NSMakeRangeV2(NSInteger min, NSInteger max)
{
  return NSMakeRange(min, max - min);
}

NS_INLINE NSInteger NSRangeMin(NSRange range)
{
  return range.location;
}

NS_INLINE NSInteger NSRangeMax(NSRange range)
{
  return range.location + range.length;
}

NS_INLINE BOOL NSIntegerIsInRange(NSInteger n, NSRange range)
{
  return n >= NSRangeMin(range) && n <= NSRangeMax(range);
}

#endif
