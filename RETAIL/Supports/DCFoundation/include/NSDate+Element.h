
#import <Foundation/Foundation.h>

typedef struct NSDateElement {
  NSInteger year;
  NSInteger month;  // [1, 12]
  NSInteger day;    // [1, daysOfMonth:year:]
  NSInteger hour;   // [0, 24]
  NSInteger minute; // [0, 60]
  NSInteger second; // [0, 60]
} NSDateElement;

@interface NSDate (Element)

+ (BOOL)validateDateElement:(NSDateElement)e;

+ (NSDate *)dateWithElement:(NSDateElement)e;
- (NSDateElement)element;

@end
