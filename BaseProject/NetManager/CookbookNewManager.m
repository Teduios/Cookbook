//
//  CookbookNewManager.m
//  BaseProject
//
//  Created by tarena on 15/12/18.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CookbookNewManager.h"
#import "CookbookPath.h"
#import "CookbookModel.h"
#import "CKCategory.h"
@implementation CookbookNewManager

+ (id)getCookbookWithCookbookID:(NSInteger)ID completionHandle:(void (^)(id, NSError *))completionHandle {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = kAppKey;
    params[@"id"] = @(ID);

    return [self POST:kCookbookPath parameters:params completionHandle:^(id responseObj, NSError *error) {
        completionHandle([CookbookModel parse:responseObj], error);
    }];
}

+ (id)getCategoryCompletionHandle:(void (^)(id, NSError *))completionHandle {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"key"] = kAppKey;

    return [self POST:kCategoryPath parameters:params completionHandle:^(id responseObj, NSError *error) {
        completionHandle([CKCategory parse:responseObj], error);
    }];
    
}

+ (id)getMenuWithMenuName:(NSString *)name pn:(NSInteger)pn completionHandle:(void (^)(id, NSError *))completionHandle {

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"menu"] = name;
    params[@"key"] = kAppKey;
    params[@"pn"] = [NSString stringWithFormat:@"%ld", pn];
    params[@"rn"] = @"10";

    
    return [self POST:kMenuPath parameters:params completionHandle:^(id responseObj, NSError *error) {
        completionHandle([CookbookModel parse:responseObj], error);
    }];
}

+ (id)getMenuWithCid:(NSInteger)cid withPn:(NSInteger)pn completionHandle:(void (^)(id, NSError *))completionHandle {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *pnStr = [NSString stringWithFormat:@"%ld",pn];
    params[@"key"] = kAppKey;
    params[@"cid"] = @(cid);
    params[@"pn"] = pnStr;
    
    return [self POST:kIndexPath parameters:params completionHandle:^(id responseObj, NSError *error) {
        completionHandle([CookbookModel parse:responseObj], error);
    }];
}


@end
