//
//  CKStepHeaderView.m
//  BaseProject
//
//  Created by tarena on 15/12/22.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CKStepHeaderView.h"
#import "UILabel+CKStepLabel.h"

static const CGFloat labelWidth = 36;
static const CGFloat labelHeight = 50;
static const CGFloat space = 5;

@implementation CKStepHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat imageViewWidth = frame.size.width;
        CGFloat imageViewHeight = imageViewWidth * 9 / 16;
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageViewWidth, imageViewHeight)];
        
        _ingredients = [UILabel labelWithFrame:CGRectMake(space * 2, imageViewHeight + space, labelWidth, labelHeight)];
        
        _ingredientsLabel = [UILabel labelWithFrame:CGRectMake(space * 3 + labelWidth, imageViewHeight + space, self.bounds.size.width - space * 5 - labelWidth, labelHeight)];
        
        _burdening = [UILabel labelWithFrame:CGRectMake(space * 2, imageViewHeight +labelHeight + space*2 , labelWidth, labelHeight)];
        _burdeningLabel = [UILabel labelWithFrame:CGRectMake(space * 3 + labelWidth, imageViewHeight + labelHeight+ space*2 , self.bounds.size.width - space * 5 - labelWidth, labelHeight)];
    
    
        _burdening.text = @"配料";
        _ingredients.text = @"原料";
        _ingredientsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
        _burdeningLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
        
        [self addSubview:_imageView];
        [self addSubview:_ingredients];
        [self addSubview:_ingredientsLabel];
        [self addSubview:_burdening];
        [self addSubview:_burdeningLabel];
    }
    return self;
}

@end
