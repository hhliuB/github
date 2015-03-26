//
//  Random.m
//  Random
//
//  Created by Duke on 12-12-24.
//  Copyright (c) 2012年 Duke. All rights reserved.
//

#import "Random.h"


#pragma mark -
#pragma mark Extern Methods

RandomRange RandomRangeMake(double min, double max) {
    if (max < min) {
        @throw [NSException exceptionWithName:@"RandomRangeException"
                                       reason:@"Minimum number of range is larger than maximum number"
                                     userInfo:nil];
        return RandomRangeZero;
    }
    
    RandomRange r;
    r.minimumNumber = min;
    r.maximumNumber = max;
    return r;
}

int compareRange (const void *a, const void *b) {
    RandomRange *r1 = (RandomRange *)a;
    RandomRange *r2 = (RandomRange *)b;
    return r1->minimumNumber - r2->minimumNumber;
}

void SortRanges(RandomRange *ranges, size_t count) {
    qsort(ranges, count, sizeof(RandomRange), compareRange);
}

bool RandomRangeIsZero(RandomRange r) {
    return r.minimumNumber == 0 && r.maximumNumber == 0;
}

bool RandomRangeIntersectsRange(RandomRange r1, RandomRange r2) {
    bool b = false;
    
    if (!RandomRangeIsZero(r1) && !RandomRangeIsZero(r2)) {
        RandomRange r[2] = {r1, r2};
        SortRanges(r, 2);
        b = r[0].maximumNumber > r[1].minimumNumber;
    }
    
    return b;
}

double RandomRangeGetLength(RandomRange r) {
    return r.maximumNumber - r.minimumNumber;
}

const RandomRange RandomRangeZero = {0.0, 0.0};

#pragma mark -
#pragma mark Implementation

@implementation Random

+ (NSInteger)randomIntegerInRange:(RandomRange)range {
    long long minInt = ceil(range.minimumNumber);
    long long maxInt = range.maximumNumber;
    
    NSInteger offset = maxInt + 1 - minInt;
    return arc4random() % offset + minInt;
}

+ (double)randomDoubleInRange:(RandomRange)range accuracy:(NSUInteger)accuracy {
    int n = 1000000;
    int m = pow(10, MIN(accuracy, 6));
    
    RandomRange r = RandomRangeMake(range.minimumNumber * n, (range.maximumNumber + (double)1.0 / m - 0.000001) * n);
    long long integer = [self randomIntegerInRange:r];
    
    return floor((double)integer / n * m) / m;
}

+ (BOOL)randomBoolean {
    return [self randomIntegerInRange:RandomRangeMake(0, 1)] == 0;
}

+ (NSString *)randomAlphabetStringByLength:(NSUInteger)length {
    // 65 - 90, 97 - 122
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        int n = [self randomIntegerInRange:RandomRangeMake(0, 51)];
        
        if (n < 26) {
            [string appendFormat:@"%c", 65 + n];
        }
        else {
            [string appendFormat:@"%c", 71 + n];
        }
    }
    
    return string;
}

+ (NSString *)randomSymbolStringByLength:(NSUInteger)length {
    // 33 - 47, 58 - 64, 91 - 96, 123 - 126
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        int n = [self randomIntegerInRange:RandomRangeMake(0, 31)];
        
        if (n < 15) {
            [string appendFormat:@"%c", 33 + n];
        }
        else if (n < 22) {
            [string appendFormat:@"%c", 43 + n];
        }
        else if (n < 28) {
            [string appendFormat:@"%c", 69 + n];
        }
        else {
            [string appendFormat:@"%c", 95 + n];
        }
    }
    
    return string;
}

+ (NSString *)randomNumberStringByLength:(NSUInteger)length {
    // 48 - 57
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        int n = [self randomIntegerInRange:RandomRangeMake(48, 57)];
        [string appendFormat:@"%c", n];
    }
    
    return string;
}

+ (NSString *)randomStringWithSymbolsByLength:(NSUInteger)length {
    // 33 - 47, 58 - 126
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        int n = [self randomIntegerInRange:RandomRangeMake(0, 83)];
        
        if (n < 15) {
            [string appendFormat:@"%c", 33 + n];
        }
        else {
            [string appendFormat:@"%c", 43 + n];
        }
    }
    
    return string;
}

+ (NSString *)randomStringWithNumbersByLength:(NSUInteger)length {
    // 48 - 57, 65 - 90, 97 - 122
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        int n = [self randomIntegerInRange:RandomRangeMake(0, 61)];
        
        if (n < 10) {
            [string appendFormat:@"%c", 48 + n];
        }
        else if (n < 36) {
            [string appendFormat:@"%c", 55 + n];
        }
        else {
            [string appendFormat:@"%c", 61 + n];
        }
    }
    
    return string;
}

+ (NSString *)randomStringWithSymbolsAndNumbersByLength:(NSUInteger)length {
    // 33 - 126
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        int n = [self randomIntegerInRange:RandomRangeMake(33, 126)];
        
        [string appendFormat:@"%c", n];
    }
    
    return string;
}

+ (NSString *)randomStringWithNumberOfSymbols:(NSUInteger)numberOfSymbols numberOfNumbers:(NSUInteger)numberOfNumbers length:(NSUInteger)length {
    if (numberOfNumbers + numberOfSymbols > length) {
        @throw [NSException exceptionWithName:@"RandomStringException"
                                       reason:@"Number of symbols & numbers is larger than length of string"
                                     userInfo:nil];
        return nil;
    }
    
    NSString *symbolString   = [self randomSymbolStringByLength:numberOfSymbols];
    NSString *numberString   = [self randomNumberStringByLength:numberOfNumbers];
    NSString *alphabetString = [self randomAlphabetStringByLength:length - numberOfSymbols - numberOfNumbers];
    
    NSMutableString *tmp_string = [NSMutableString stringWithFormat:@"%@%@%@", symbolString, numberString, alphabetString];
    
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        int n = [self randomIntegerInRange:RandomRangeMake(0, tmp_string.length - 1)];
        NSRange r = NSMakeRange(n, 1);
        
        [string appendString:[tmp_string substringWithRange:r]];
        
        [tmp_string deleteCharactersInRange:r];
    }
    
    return string;
}

@end
