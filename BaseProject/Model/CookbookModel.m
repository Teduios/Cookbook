//
//  CookbookModel.m
//  BaseProject
//
//  Created by tarena on 15/12/18.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CookbookModel.h"

@implementation CookbookModel

@end

@implementation Result

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [Data class]};
}

@end


@implementation Data

+ (NSDictionary *)objectClassInArray{
    return @{@"steps" : [Steps class]};
}

@end


@implementation Steps

@end


