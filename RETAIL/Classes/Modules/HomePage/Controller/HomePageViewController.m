//
//  HomePageViewController.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/16.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "HomePageViewController.h"

#import "MainViewController.h"
#import "ChannelDetailViewController.h"

#import "HPHeaderView.h"
#import "HPScrollerView.h"
#import "HPContentView.h"

#import "HPHeaderSegmentButtonProtocol.h"
#import "HPBottomViewProtocol.h"

@interface HomePageViewController ()

@property (nonatomic,strong) MainViewController *mainViewController;

@property (nonatomic,strong) UIScrollView *allScrollerView;

@property (nonatomic,strong) HPHeaderView   *headerView;
@property (nonatomic,strong) HPScrollerView *scrollerView;
@property (nonatomic,strong) HPContentView  *contentView;

@property (nonatomic,strong) HPHeaderSegmentButtonProtocol *segmentButtonProtocol;
@property (nonatomic,strong) HPBottomViewProtocol          *bottomProtocol;

@end

@implementation HomePageViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  CGFloat width = self.view.width;
  CGFloat height = self.view.height;
  
  _allScrollerView = [self.view addViewWithFrame:CGRectMake(0, 61, width, height - 10) class:[UIScrollView class] backgroundColor:kDarkGrayColor];
  _allScrollerView.contentSize = CGSizeMake(width, 230 * 6);
  _allScrollerView.showsVerticalScrollIndicator = NO;

  self.headerView = [self.view addViewWithFrame:CGRectMake(0, 0, width, 60) class:[HPHeaderView class] backgroundColor:kLightGrayColor];
  
  self.scrollerView = [self.allScrollerView addViewWithFrame:CGRectMake(0, 1, width, 275) class:[HPScrollerView class] backgroundColor:kLightBlueColor];
  
  self.contentView = [self.allScrollerView addViewWithFrame:CGRectMake(0, 280, width, 1050) class:[HPContentView class] backgroundColor:kClearColor];
  
  self.contentView.bottomView.delegate = self.bottomProtocol;
  [self.contentView.bottomView reloadData];
  
  self.contentView.segmentButton.delegate = self.segmentButtonProtocol;
}

- (void)showRecommentTableView
{
  self.contentView.segmentButton.userInteractionEnabled = NO;
  
  UIViewReloadAnimationDirection rowAnimationDirection;
  rowAnimationDirection = UIViewReloadAnimationDirectionLeft;
  
  [self.contentView.bottomView reloadWithAnimationDirection:rowAnimationDirection reloadDataBlock:^{
    self.contentView.bottomView.numberOfTag = 0;
    [self.contentView.bottomView reloadData];
  } completion:^{
    self.contentView.segmentButton.userInteractionEnabled = YES;
  }];
}

- (void)showHitTableView
{
  self.contentView.segmentButton.userInteractionEnabled = NO;
  
  UIViewReloadAnimationDirection rowAnimationDirection;
  rowAnimationDirection = UIViewReloadAnimationDirectionRight;
  
  [self.contentView.bottomView reloadWithAnimationDirection:rowAnimationDirection reloadDataBlock:^{
    self.contentView.bottomView.numberOfTag = 1;
    [self.contentView.bottomView reloadData];
  } completion:^{
    self.contentView.segmentButton.userInteractionEnabled = YES;
  }];
}

- (void)selectMovieAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"选择了第 %d 行，%d 列",indexPath.section,indexPath.row);
  
  ChannelDetailViewController *detailController = [[ChannelDetailViewController alloc]init];
  [self.mainViewController pushViewController:detailController completion:^{
    
  }];
  
}

- (MainViewController *)mainViewController
{
  return [MainViewController getInstance];
}

- (HPHeaderSegmentButtonProtocol *)segmentButtonProtocol
{
  if (!_segmentButtonProtocol) {
    _segmentButtonProtocol = [[HPHeaderSegmentButtonProtocol alloc]init];
    _segmentButtonProtocol.controller = self;
  }
  return _segmentButtonProtocol;
}

- (HPBottomViewProtocol *)bottomProtocol
{
  if (!_bottomProtocol) {
    _bottomProtocol = [[HPBottomViewProtocol alloc]init];
    _bottomProtocol.controller = self;
  }
  return _bottomProtocol;
}

@end
