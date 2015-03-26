
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NSDateFormat) {
	NSDateFormatFull,                     // 2012-11-30 18:30:59
	NSDateFormatYear,                     // 2012
	NSDateFormatMonth,                    // 11
	NSDateFormatDay,                      // 30
	NSDateFormatYearMonthDayPoint,        // 2012.11.30
	NSDateFormatYearMonthDay,             // 2012-11-30
	NSDateFormatYearMonth,                // 2012-11
	NSDateFormatMonthDay,                 // 11-30
	NSDateFormatHour,                     // 18
	NSDateFormatMinute,                   // 30
	NSDateFormatSecond,                   // 59
	NSDateFormatHourMinuteSecond,         // 18:30:59
	NSDateFormatHourMinute,               // 18:30
	NSDateFormatMinuteSecond,             // 30:59
  NSDateFormatMonthDayHourMinute,       // 11-30 18:30
	NSDateFormatDayOfWeek,                // 1~7 (1为星期日)
  
  NSDateFormatMonth_English,            // Jan
  
  // Chinese Formats
  NSDateFormatYearMonth_Chinese,
	NSDateFormatYearMonthDay_Chinese,     // 2012年11月30日
	NSDateFormatMonthDay_Chinese,         // 11月30日
  NSDateFormatYearMonthDayAMPM_Chinese, // 2012年11月30日 下午
  
  NSDateFormatAMPM
};

@interface NSDate (DateFormat)

- (NSString *)stringWithFormat:(NSDateFormat)format;

@end


@interface NSString (DateFormat)

- (NSDate *)dateWithFormat:(NSDateFormat)format;

@end
