//
//  ChannelViewController.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/16.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "ChannelViewController.h"

#import "ChannelDetailViewController.h"

#import "ChannelTableViewProtocol.h"
#import "ChannelCollectionViewProtocol.h"

#import "HPHeaderView.h"
#import "ChannelView.h"

#import "MainViewController.h"

@interface ChannelViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) ChannelView *view;

@property (nonatomic,strong) MainViewController *mainViewController;

@property (nonatomic,strong) ChannelTableViewProtocol *tableViewProtocol;
@property (nonatomic,strong) ChannelCollectionViewProtocol *collectionViewProtocol;

@property (nonatomic,assign) NSInteger lastTableViewIndex;

@end

@implementation ChannelViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  CGFloat width = self.view.frame.size.width;
  
  self.lastTableViewIndex = -1;
  
  self.view.tableView.dataSource = self.tableViewProtocol;
  self.view.tableView.delegate   = self.tableViewProtocol;
  self.view.tableView.rowHeight  = width / 7;

  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  
  [self.view.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
  
  self.view.collectionView.delegate   = self.collectionViewProtocol;
  self.view.collectionView.dataSource = self.collectionViewProtocol;
  
  self.view.backgroundColor = kClearColor;
}

- (void)selectChannelForIndex:(NSInteger)index
{
  UIViewReloadAnimationDirection rowAnimationDirection;
  if (index < self.lastTableViewIndex) {
    rowAnimationDirection = UIViewReloadAnimationDirectionLeft;
  }
  else{
    rowAnimationDirection = UIViewReloadAnimationDirectionRight;
  }
  self.lastTableViewIndex = index;
  [self.view.collectionView reloadWithAnimationDirection:rowAnimationDirection reloadDataBlock:^{
    [self.view.collectionView reloadData];
  } completion:^{
    nil;
  }];

}

- (void)selectMovieForIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"选择了 %d 行，%d 列",indexPath.section,indexPath.row);
  
  ChannelDetailViewController *detailController = [[ChannelDetailViewController alloc]init];
  
  [self.mainViewController pushViewController:detailController completion:^{
  
  }];
}

- (Class)viewClass
{
  return [ChannelView class];
}

- (MainViewController *)mainViewController
{
  return [MainViewController getInstance];
}

- (ChannelTableViewProtocol *)tableViewProtocol
{
  if (!_tableViewProtocol) {
    _tableViewProtocol = [[ChannelTableViewProtocol alloc]init];
    _tableViewProtocol.controller = self;
  }
  return _tableViewProtocol;
}

- (ChannelCollectionViewProtocol *)collectionViewProtocol
{
  if (!_collectionViewProtocol) {
    _collectionViewProtocol = [[ChannelCollectionViewProtocol alloc]init];
    _collectionViewProtocol.controller = self;
  }
  return _collectionViewProtocol;
}

@end
