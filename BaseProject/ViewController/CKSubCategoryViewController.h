//
//  CKSubCategoryViewController.h
//  BaseProject
//
//  Created by tarena on 15/12/23.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseViewController.h"
#import "CookbookModel.h"

extern const NSString * CKSubcategoryViewControllerIdentifier;

@interface CKSubCategoryViewController : BaseViewController

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger cid;

@end
