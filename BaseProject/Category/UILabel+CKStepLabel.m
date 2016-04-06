//
//  UILabel+CKStepLabel.m
//  BaseProject
//
//  Created by tarena on 15/12/22.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "UILabel+CKStepLabel.h"

@implementation UILabel (CKStepLabel)

+ (UILabel *)labelWithFrame:(CGRect)frame {
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"loading...";
    label.numberOfLines = 0;
    
    return label;
}

@end
