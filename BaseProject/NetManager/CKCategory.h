//
//  CKCategory.h
//  BaseProject
//
//  Created by tarena on 15/12/19.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseModel.h"

@class CKResult,CKList;
@interface CKCategory : BaseModel


@property (nonatomic, strong) NSArray<CKResult *> *result;

@property (nonatomic, copy) NSString *resultcode;

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, assign) NSInteger error_code;

- (BOOL)createDataBaseTable;

@end
@interface CKResult : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parentId;

@property (nonatomic, strong) NSArray<CKList *> *list;

@end

@interface CKList : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parentId;

@end

