//
//  Entities.h
//  MVVMDemo
//
//  Created by Duke Cui on 14/12/5.
//  Copyright (c) 2014年 Duke Cui. All rights reserved.
//

#import "SFAObject.h"

@interface User : SFAObject

@property (nonatomic,assign) int Id;              //用户ID;
@property (nonatomic,assign) int videos_count;    //总视频数
@property (nonatomic,assign) int playlists_count; //总专辑数
@property (nonatomic,assign) int favorites_count; //总收藏视频数
@property (nonatomic,assign) int followers_count; //粉丝数
@property (nonatomic,assign) int following_count; //关注数
@property (nonatomic,assign) int statuses_count;  //动态数
@property (nonatomic,assign) int subscribe_count; //被订阅数
@property (nonatomic,assign) int vv_count;        //总视频播放数

@property (nonatomic,copy) NSString *name;        //用户名
@property (nonatomic,copy) NSString *link;        //用户地址
@property (nonatomic,copy) NSString *avatar;      //头像
@property (nonatomic,copy) NSString *avatar_large;//大头像
@property (nonatomic,copy) NSString *gender;      //性别 男：m 女：f 未知：u
@property (nonatomic,copy) NSString *uDescription; //描述
@property (nonatomic,copy) NSString *regist_time; //注册时间

@end

@interface Video : SFAObject

@property (nonatomic,copy) NSString *Id;                 //视频唯一ID
@property (nonatomic,copy) NSString *title;          //视频标题
@property (nonatomic,copy) NSString *link;           //视频播放链接
@property (nonatomic,copy) NSString *thumbnail;      //视频截图
@property (nonatomic,copy) NSString *bigThumbnail;
@property (nonatomic,copy) NSString *category;       //视频分类
@property (nonatomic,copy) NSString *state;          //视频状态 normal: 正常 encoding: 转码中 fail: 转码失败 in_review: 审核中 blocked: 已屏蔽
@property (nonatomic,copy) NSString *published;      //发布时间
@property (nonatomic,copy) NSString *vDescription;   //视频描述
@property (nonatomic,copy) NSString *favorite_time;  //收藏时间

@property (nonatomic,copy) NSString *player;         //播放器
@property (nonatomic,copy) NSString *public_type;    //公开类型 all: 公开 friend: 仅好友观看 password: 输入密码观看
@property (nonatomic,copy) NSString *copyright_type; //版权所有 original: 原创 reproduced: 转载

@property (nonatomic,assign) int duration;           //视频时长，单位：秒
@property (nonatomic,assign) int view_count;         //总播放数
@property (nonatomic,assign) int favorite_count;     //总收藏数
@property (nonatomic,assign) int comment_count;      //总评论数
@property (nonatomic,assign) int up_count;           //总顶数
@property (nonatomic,assign) int down_count;         //总踩数

@property (nonatomic,copy) User *user;               //上传用户对象
@property (nonatomic,copy) NSArray *operation_limit; //操作限制 COMMENT_DISABLED: 禁评论 DOWNLOAD_DISABLED: 禁下载
@property (nonatomic,copy) NSArray *streamtypes;     //视频格式 flvhd flv 3gphd 3gp hd hd2


@end
