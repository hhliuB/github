//
//  HitViewController.m
//  RETAIL
//
//  Created by Liu Huanhuan on 15/3/16.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "SearchViewController.h"

#import "SearchTableViewProtocol.h"

#import "HPHeaderView.h"

@interface SearchViewController ()

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) HPHeaderView *headerView;

@property (nonatomic,strong) SearchTableViewProtocol *tableViewProtocol;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  CGFloat width  = self.view.frame.size.width;
  CGFloat height = self.view.frame.size.height;
  
  self.headerView = [self.view addViewWithFrame:CGRectMake(0, 0, width, 60)
                                          class:[HPHeaderView class]
                                backgroundColor:kLightGrayColor];
  
  self.textField = [[UITextField alloc]initWithFrame:CGRectMake((width - 700) / 2, 80, 700, 40)];
  self.textField.backgroundColor = kLightGrayColor;
  self.textField.borderStyle     = UITextBorderStyleRoundedRect;
  self.textField.leftViewMode    = UITextFieldViewModeAlways;
  
  [self.view addSubview:self.textField];
  
  [self.view addLabelWithFrame:CGRectMake((width - 80) / 2, 140, 80, 20) text:@"热门搜索"];
  
  self.tableView = [self.view addViewWithFrame:CGRectMake((width - 700) / 2, 165, 700, height - 170)
                                         class:[UITableView class]
                               backgroundColor:kLightGrayColor];
  
  self.tableView.rowHeight  = 70;
  self.tableView.delegate   = self.tableViewProtocol;
  self.tableView.dataSource = self.tableViewProtocol;
  self.tableView.layer.cornerRadius = 5;
  self.view.backgroundColor = kClearColor;
}

- (void)searchMovieWithString:(NSString *)string
{
  [self.textField setText:string];
}

- (SearchTableViewProtocol *)tableViewProtocol
{
  if (!_tableViewProtocol) {
    _tableViewProtocol = [[SearchTableViewProtocol alloc]init];
    _tableViewProtocol.controller = self;
  }
  return _tableViewProtocol;
}

@end
