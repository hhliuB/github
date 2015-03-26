
#import <Foundation/Foundation.h>

#define MSECONDS_PER_DAY  86400000
#define SECONDS_PER_DAY   86400

#define MSECONDS_PER_HOUR 3600000
#define SECONDS_PER_HOUR  3600

#define MSECONDS_PER_MINITE 60000
#define SECONDS_PER_MINITE  60

#define HOURS_PER_DAY 24
#define MIDDAY_HOUR   12

NS_INLINE NSDate* Now() {
  return [NSDate date];
}

@interface NSDate (DCFoundation)

- (long long)milliseconds;
+ (NSDate *)dateWithMilliseconds:(long long )milliseconds;

- (BOOL)isSameDayWithDate:(NSDate *)otherDate;
- (BOOL)isToday;
- (BOOL)isThisWeek;
- (BOOL)isThisMonth;

- (NSString *)dayOfWeekInChinese;

- (BOOL)isExpired;

+ (NSDate *)firstDayOfMonth;
+ (NSDate *)lastDayOfMonth;

+ (NSDate *)firstDayOfWeek;
+ (NSDate *)lastDayOfWeek;

+ (NSDate *)today;

- (long long)millisecondsAtHour:(NSInteger)hour;

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;

- (NSInteger)nextYear;
- (NSInteger)nextMonth;
- (NSInteger)yearForNextMonth;

+ (NSInteger)monthOfString:(NSString *)str;
+ (NSString *)stringOfMonth:(NSInteger)month;
+ (NSString *)fullStringOfMonth:(NSInteger)month;

+ (NSInteger)daysOfMonth:(NSInteger)month year:(NSInteger)year;
+ (BOOL)isLeapYear:(NSInteger)year;

- (BOOL)isAM;
- (BOOL)isPM;

NS_INLINE BOOL MillisecondsIsAM(long long ms)
{
  return [[NSDate dateWithMilliseconds:ms] isAM];
}

NS_INLINE BOOL MillisecondsIsPM(long long ms)
{
  return [[NSDate dateWithMilliseconds:ms] isPM];
}

@end
