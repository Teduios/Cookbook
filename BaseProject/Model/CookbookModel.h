//
//  CookbookModel.h
//  BaseProject
//
//  Created by tarena on 15/12/18.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseModel.h"

@class Result,Data,Steps;
@interface CookbookModel : BaseModel

@property (nonatomic, strong) Result *result;

@property (nonatomic, copy) NSString *resultcode;

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, assign) NSInteger error_code;


@end
@interface Result : NSObject

@property (nonatomic, assign) NSInteger totalNum;

@property (nonatomic, strong) NSArray<Data *> *data;

@property (nonatomic, assign) NSInteger pn;

@property (nonatomic, assign) NSInteger rn;

@end

@interface Data : NSObject

@property (nonatomic, copy) NSString *burden;

@property (nonatomic, strong) NSArray<NSString *> *albums;

@property (nonatomic, copy) NSString *imtro;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *ingredients;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<Steps *> *steps;

@property (nonatomic, copy) NSString *tags;

@end

@interface Steps : NSObject

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *step;

@end

