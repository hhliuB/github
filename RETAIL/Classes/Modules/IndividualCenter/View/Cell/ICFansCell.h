//
//  ICFansCell.h
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/23.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICFansCell : UITableViewCell

@property (nonatomic,readonly) UIImageView *iconImage;

@property (nonatomic,readonly) UILabel *nameLabel;
@property (nonatomic,readonly) UILabel *descriptionLabel;

@property (nonatomic,readonly) UILabel *fansCount;
@property (nonatomic,readonly) UILabel *videosCount;

@property (nonatomic,readonly) UILabel *followingLabel;
@property (nonatomic,readonly) UILabel *followingImage;

@property (nonatomic,assign) BOOL following;

@end
