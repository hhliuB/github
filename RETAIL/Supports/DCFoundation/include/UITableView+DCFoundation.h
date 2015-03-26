
#import <UIKit/UIKit.h>

@interface UITableView (DCFoundation)

- (void)selectFirstRow;

- (void)selectRow:(NSInteger)row;

- (void)selectRow:(NSInteger)row inSection:(NSInteger)section;

- (void)selectRow:(NSInteger)row
        inSection:(NSInteger)section
         animated:(BOOL)animated
   scrollPosition:(UITableViewScrollPosition)scrollPosition;

- (void)deselectRows;

@end
