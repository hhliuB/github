//
//  Entities.h
//  MVVMDemo
//
//  Created by Duke Cui on 14/12/5.
//  Copyright (c) 2014年 Duke Cui. All rights reserved.
//

#import "SFAObject.h"

@interface FirstEntity : SFAObject

@property (nonatomic,copy)   NSString *title;
@property (nonatomic,assign) CGFloat   highTemperature;
@property (nonatomic,assign) CGFloat   lowTemperature;

@end

@interface SecondEntity : SFAObject

@property (nonatomic,copy)   NSString  *title;
@property (nonatomic,copy)   NSString  *pinyin;
@property (nonatomic,assign) long long  size;

@property (nonatomic,assign) BOOL isLocal;
@property (nonatomic,assign) BOOL isFavorite;
@property (nonatomic,assign) BOOL isCommonUse;

@end
