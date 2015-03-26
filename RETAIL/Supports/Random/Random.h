//
//  Random.h
//  Random
//
//  Created by Duke on 12-12-24.
//  Copyright (c) 2012年 Duke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _RandomRange {
    double minimumNumber;
    double maximumNumber;
} RandomRange;

extern RandomRange RandomRangeMake(double min, double max);
extern      double RandomRangeGetLength(RandomRange r);

extern const RandomRange RandomRangeZero;

@interface Random : NSObject

+ (NSInteger)randomIntegerInRange:(RandomRange)range; // Includes minimum and maximum numbers
+ (double)randomDoubleInRange:(RandomRange)range accuracy:(NSUInteger)accuracy; // accuracy <= 6
+ (BOOL)randomBoolean;

+ (NSString *)randomAlphabetStringByLength:(NSUInteger)length;
+ (NSString *)randomSymbolStringByLength:(NSUInteger)length;
+ (NSString *)randomNumberStringByLength:(NSUInteger)length;
+ (NSString *)randomStringWithSymbolsByLength:(NSUInteger)length;
+ (NSString *)randomStringWithNumbersByLength:(NSUInteger)length;
+ (NSString *)randomStringWithSymbolsAndNumbersByLength:(NSUInteger)length;
+ (NSString *)randomStringWithNumberOfSymbols:(NSUInteger)numberOfSymbols numberOfNumbers:(NSUInteger)numberOfNumbers length:(NSUInteger)length;

@end
