//
//  CKTableViewCell.m
//  BaseProject
//
//  Created by tarena on 15/12/22.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CKTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface CKTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *ckImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end



@implementation CKTableViewCell

- (void)setData:(Data *)data {
    self.titleLabel.text = data.title;
    self.introLabel.text = data.imtro;
    NSString *imageStr = data.albums[0];
    [self.ckImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
