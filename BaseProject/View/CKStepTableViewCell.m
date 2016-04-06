//
//  CKStepTableViewCell.m
//  BaseProject
//
//  Created by tarena on 15/12/22.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CKStepTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface CKStepTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ckImageView;

@end



@implementation CKStepTableViewCell

- (void)setStep:(Steps *)step {
    self.stepLabel.text = step.step;
    self.stepLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    NSString *imageStr = step.img;
    [self.ckImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}

@end
