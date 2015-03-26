//
//  IndividualCenterViewController.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/16.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "IndividualCenterViewController.h"

#import "HPHeaderView.h"
#import "ICListView.h"
#import "ICDetailView.h"

#import "ICListTableViewProtocol.h"
#import "ICCollectionProgramViewProtocol.h"
#import "ICHistoryViewProtocol.h"
#import "ICOffineCacheViewProtocol.h"
#import "ICPlayDefinitionProtocol.h"
#import "ICCacheDefinitionProtocol.h"
#import "ICFansListProtocol.h"

#import "UserViewModel.h"

@interface IndividualCenterViewController ()

@property (nonatomic,strong) HPHeaderView *headerView;
@property (nonatomic,strong) ICListView   *listView;
@property (nonatomic,strong) ICDetailView *detailView;

@property (nonatomic,strong) ICListTableViewProtocol         *listTableViewProtocol;
@property (nonatomic,strong) ICCollectionProgramViewProtocol *collectionProtocol;
@property (nonatomic,strong) ICHistoryViewProtocol           *historyProtocol;
@property (nonatomic,strong) ICOffineCacheViewProtocol       *offineCacheProtocol;
@property (nonatomic,strong) ICPlayDefinitionProtocol        *playDefinitionProtocol;
@property (nonatomic,strong) ICCacheDefinitionProtocol       *cacheDefinitionProtocol;
@property (nonatomic,strong) ICFansListProtocol              *fansListProtocol;

@property (nonatomic,assign) NSInteger lastListIndex;

@property (nonatomic,strong) UserViewModel *userViewModel;

@end

@implementation IndividualCenterViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.userViewModel loadData:^{
    
  }];
  
  self.lastListIndex = -1;
  
  self.headerView = [self.view addViewWithFrame:CGRectMake(0, 0, self.view.width, 60) class:[HPHeaderView class] backgroundColor:kLightGrayColor];
  
  self.listView = [self.view addViewWithFrame:CGRectMake(0, 62, kLeftViewWidth, self.view.height - 63) class:[ICListView class] backgroundColor:kWhiteColor];
  self.listView.tableView.delegate   = self.listTableViewProtocol;
  self.listView.tableView.dataSource = self.listTableViewProtocol;
  [self.listView.tableView selectRow:0 inSection:0];
  
  self.detailView = [self.view addViewWithFrame:CGRectMake(kRightViewX, 62, kRightViewWidth - 4, self.view.height - 62) class:[ICDetailView class] backgroundColor:kWhiteColor];
  
  self.detailView.collectionProgramView.collectionView.delegate   = self.collectionProtocol;
  self.detailView.collectionProgramView.collectionView.dataSource = self.collectionProtocol;
  
  self.detailView.historyView.collectionView.delegate   = self.historyProtocol;
  self.detailView.historyView.collectionView.dataSource = self.historyProtocol;
  
  self.detailView.offineCacheView.collectionView .delegate  = self.offineCacheProtocol;
  self.detailView.offineCacheView.collectionView.dataSource = self.offineCacheProtocol;
  
  self.detailView.basicSettingView.playDefinitionTableView.delegate   = self.playDefinitionProtocol;
  self.detailView.basicSettingView.playDefinitionTableView.dataSource = self.playDefinitionProtocol;
  [self.detailView.basicSettingView.cacheDefinitionTableView selectRow:1 inSection:0];
  
  self.detailView.basicSettingView.cacheDefinitionTableView.delegate   = self.cacheDefinitionProtocol;
  self.detailView.basicSettingView.cacheDefinitionTableView.dataSource = self.cacheDefinitionProtocol;
  [self.detailView.basicSettingView.cacheDefinitionTableView selectRow:1 inSection:0];
  
  self.detailView.fansListView.tableView.delegate = self.fansListProtocol;
  self.detailView.fansListView.tableView.dataSource = self.fansListProtocol;
  
//  [[[Biz alloc]init] ]
  
}

- (void)selectListItemAtIndex:(NSInteger)index
{
  UIViewReloadAnimationDirection rowAnimationDirection;
  if (index < self.lastListIndex) {
    rowAnimationDirection = UIViewReloadAnimationDirectionTop;
  }
  else{
    rowAnimationDirection = UIViewReloadAnimationDirectionBottom;
  }
  self.lastListIndex = index;
  [self.detailView reloadWithAnimationDirection:rowAnimationDirection reloadDataBlock:^{
    [self showDetailViewAtIndex:index];
  } completion:^{
    nil;
  }];

}

- (void)showDetailViewAtIndex:(NSInteger)index
{
  self.detailView.basicInformationView.hidden  = YES;
  self.detailView.basicSettingView.hidden      = YES;
  self.detailView.collectionProgramView.hidden = YES;
  self.detailView.fansListView.hidden          = YES;
  self.detailView.offineCacheView.hidden       = YES;
  self.detailView.historyView.hidden           = YES;
  self.detailView.versionView.hidden           = YES;
  self.detailView.feedbackView.hidden          = YES;

  switch (index) {
    case 0:
      self.detailView.basicInformationView.hidden  = NO;break;
    case 1:
      self.detailView.basicSettingView.hidden      = NO;break;
    case 2:
      self.detailView.collectionProgramView.hidden = NO;break;
    case 3:
      self.detailView.fansListView.hidden          = NO;break;
    case 4:
      self.detailView.offineCacheView.hidden       = NO;break;
    case 5:
      self.detailView.historyView.hidden           = NO;break;
    case 6:
      self.detailView.versionView.hidden           = NO;break;
    case 7:
      self.detailView.feedbackView.hidden          = NO;break;
    default:
      break;
  }
}

- (void)selectMovieForIndexPath:(NSIndexPath *)indexPath
{
//  NSLog(@"选择了 %d 行，%d 列",indexPath.section,indexPath.row);
//  
//  ChannelDetailViewController *detailController = [[ChannelDetailViewController alloc]init];
//  
//  [self.mainViewController pushViewController:detailController completion:^{
//    
//  }];
}

- (void)selectCacheDefinitionWithString:(NSString *)string
{
  [self.detailView.basicSettingView.cacheDefinitionLable setText:string];
}

- (void)selectPlayDefinitionWithString:(NSString *)string
{
  [self.detailView.basicSettingView.playDefinitionLabel setText:string];
}

- (ICListTableViewProtocol *)listTableViewProtocol
{
  if (!_listTableViewProtocol) {
    _listTableViewProtocol = [[ICListTableViewProtocol alloc]init];
    _listTableViewProtocol.controller = self;
  }
  return _listTableViewProtocol;
}

- (ICCollectionProgramViewProtocol *)collectionProtocol
{
  if (!_collectionProtocol) {
    _collectionProtocol = [[ICCollectionProgramViewProtocol alloc]init];
    _collectionProtocol.controller = self;
  }
  return _collectionProtocol;
}

- (ICHistoryViewProtocol *)historyProtocol
{
  if (!_historyProtocol) {
    _historyProtocol = [[ICHistoryViewProtocol alloc]init];
    _historyProtocol.controller = self;
  }
  return _historyProtocol;
}

- (ICOffineCacheViewProtocol *)offineCacheProtocol
{
  if (!_offineCacheProtocol) {
    _offineCacheProtocol = [[ICOffineCacheViewProtocol alloc]init];
    _offineCacheProtocol.controller = self;
  }
  return _offineCacheProtocol;
}

- (ICPlayDefinitionProtocol *)playDefinitionProtocol
{
  if (!_playDefinitionProtocol) {
    _playDefinitionProtocol = [[ICPlayDefinitionProtocol alloc]init];
    _playDefinitionProtocol.controller = self;
  }
  return _playDefinitionProtocol;
}

- (ICCacheDefinitionProtocol *)cacheDefinitionProtocol
{
  if (!_cacheDefinitionProtocol) {
    _cacheDefinitionProtocol = [[ICCacheDefinitionProtocol alloc]init];
    _cacheDefinitionProtocol.controller = self;
  }
  return _cacheDefinitionProtocol;
}

- (ICFansListProtocol *)fansListProtocol
{
  if (!_fansListProtocol) {
    _fansListProtocol = [[ICFansListProtocol alloc]init];
    _fansListProtocol.controller = self;
  }
  return _fansListProtocol;
}

- (UserViewModel *)userViewModel
{
  if (!_userViewModel) {
    _userViewModel = [[UserViewModel alloc]init];
  }
  return _userViewModel;
}

@end
