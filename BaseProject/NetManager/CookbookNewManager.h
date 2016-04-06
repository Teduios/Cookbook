//
//  CookbookNewManager.h
//  BaseProject
//
//  Created by tarena on 15/12/18.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseNetManager.h"

@interface CookbookNewManager : BaseNetManager

+ (id)getCookbookWithCookbookID:(NSInteger )ID completionHandle:(void(^)(id model,NSError *error))completionHandle;
+ (id)getCategoryCompletionHandle:(void(^)(id model,NSError *error))completionHandle;
+ (id)getMenuWithMenuName:(NSString *)name pn:(NSInteger)pn completionHandle:(void(^)(id model,NSError *error))completionHandle;
+ (id)getMenuWithCid:(NSInteger)cid withPn:(NSInteger)pn completionHandle:(void (^)(id model, NSError *error))completionHandle;

@end
