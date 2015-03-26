//
//  LibraryEntities.h
//  RETAIL
//
//  Created by Duke Cui on 15/2/4.
//  Copyright (c) 2015年 Duke Cui. All rights reserved.
//

#import "SFAObject.h"

@interface Folder : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *name;
@property (copy) NSString *parentId;

@property (assign) NSInteger numberOfDocuments;

@end

@interface Document : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *name;
@property (copy) NSString *folderId;
@property (copy) NSString *updateDate;
@property (copy) NSString *expiredDate;

@end
