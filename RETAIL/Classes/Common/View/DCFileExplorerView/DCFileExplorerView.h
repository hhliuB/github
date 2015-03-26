//
//  DCFileExplorerView.h
//  DCFileExplorer
//
//  Created by Duke on 13-10-21.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCTableViewCell.h"

typedef DCTableViewCell DCFileExplorerViewCell;

@protocol DCFileExplorerViewDataSource;
@protocol DCFileExplorerViewDelegate;

@interface DCFileExplorerView : UIView

@property(nonatomic) id<DCFileExplorerViewDataSource> dataSource;
@property(nonatomic) id<DCFileExplorerViewDelegate>   delegate;

@property(nonatomic) CGFloat rowHeight;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (void)reloadData;
- (void)reloadDataWithRowAnimation:(UITableViewRowAnimation)animation;

- (NSIndexPath *)indexPathOfFolderAtIndex:(NSInteger)index;
- (NSIndexPath *)indexPathOfFileAtIndex:(NSInteger)index;
- (DCTableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths;

- (void)selectFileAtIndex:(NSInteger)index
                 animated:(BOOL)animated
           scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)deselectFileAtIndex:(NSInteger)index
                   animated:(BOOL)animated;

@end

@protocol DCFileExplorerViewDataSource <NSObject>

@required
- (NSInteger)numberOfFoldersForFileExplorerView:(DCFileExplorerView *)fileExplorerView;
- (NSInteger)numberOfFilesForFileExplorerView:(DCFileExplorerView *)fileExplorerView;

- (DCFileExplorerViewCell *)fileExplorerView:(DCFileExplorerView *)fileExplorerView
                           folderCellAtIndex:(NSInteger)index;

- (DCFileExplorerViewCell *)fileExplorerView:(DCFileExplorerView *)fileExplorerView
                             fileCellAtIndex:(NSInteger)index;

- (BOOL)fileExplorerView:(DCFileExplorerView *)fileExplorerView
    shouldSlideFileCellToLeftAtIndex:(NSInteger)index;
- (BOOL)fileExplorerView:(DCFileExplorerView *)fileExplorerView
    shouldSlideFileCellToRightAtIndex:(NSInteger)index;

@end

@protocol DCFileExplorerViewDelegate <NSObject>

@optional
- (void)fileExplorerView:(DCFileExplorerView *)fileExplorerView
    didSelectFolderAtIndex:(NSInteger)index;
- (void)fileExplorerView:(DCFileExplorerView *)fileExplorerView
    didSelectFileAtIndex:(NSInteger)index;

@end
