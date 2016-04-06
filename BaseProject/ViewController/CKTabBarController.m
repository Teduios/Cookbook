//
//  CKTabBarController.m
//  BaseProject
//
//  Created by tarena on 15/12/22.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CKTabBarController.h"

@interface CKTabBarController ()

@end

@implementation CKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor royalBlue];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
//    self.panToSwitchGestureRecognizerEnabled = NO;
    /*
//    self.tabBar.hidden = YES;
    
    self.ckTabBar = [UIView new];
    self.ckTabBar.backgroundColor = [UIColor doderBlue];
     
//    [self.view addSubview:self.ckTabBar];
    [self.ckTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(44);
        NSArray *titlesArray = @[@"首页",@"分类",@"查找"];
        
        UIButton *lastBtn = nil;
        for (int i = 0; i < titlesArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.tag = i;
            [btn setTitle:titlesArray[i] forState:UIControlStateNormal];
            btn.tintColor = [UIColor whiteColor];
            
            [btn bk_addEventHandler:^(id sender) {
                self.selectedIndex = btn.tag;
                
            } forControlEvents:UIControlEventTouchUpInside];
            
            [self.ckTabBar addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.bottom.mas_equalTo(0);
                if (0 == i) {
                    make.left.mas_equalTo(0);
                }else {
                    make.width.mas_equalTo(lastBtn);
                    make.left.mas_equalTo(lastBtn.mas_right).mas_equalTo(0);
                    if (i == titlesArray.count-1) {
                        make.right.mas_equalTo(0);
                    }
                }
            }];
            lastBtn = btn;
        }
    }];
     */
    
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}


@end
