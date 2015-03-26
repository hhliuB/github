//
//  ICBasicInformationView.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/20.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "DCView.h"

@interface ICBasicInformationView : DCView

@property (nonatomic,readonly) UIImageView *iconImage;

@property (nonatomic,readonly) UILabel  *nameLabel;
@property (nonatomic,readonly) UILabel  *descriptionLabel;

@property (nonatomic,readonly) UILabel  *nickNameLabel;
@property (nonatomic,readonly) UILabel  *genderLabel;

@property (nonatomic,readonly) UILabel  *fansCount;
@property (nonatomic,readonly) UILabel  *favoritesCount;
@property (nonatomic,readonly) UILabel  *videosCount;
@property (nonatomic,readonly) UILabel  *followingCount;
@property (nonatomic,readonly) UILabel  *registTime;



@end
