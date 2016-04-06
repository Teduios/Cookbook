//
//  CKStepsViewController.m
//  BaseProject
//
//  Created by tarena on 15/12/22.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CKStepsViewController.h"
#import <UIImageView+WebCache.h>
#import "CKStepTableViewCell.h"
#import "CKStepHeaderView.h"
#import "UMSocial.h"

@interface CKStepsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *stepsArray;
@property (nonatomic, strong) UIImageView *ckImageView;

@end

static  NSString *const identifier = @"CKStepCell";

@implementation CKStepsViewController

- (NSArray *)stepsArray {
    if (!_stepsArray) {
        _stepsArray = self.data.steps;
    }
    return _stepsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 90;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CKStepTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    [self setupHeaderView];
    self.navigationItem.title = self.data.title;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"分享"
                                                                                 style:UIBarButtonItemStylePlain
                                                                               handler:^(id sender) {
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:kUMAppKey
                                          shareText:self.data.title
                                         shareImage:self.ckImageView.image
                                    shareToSnsNames:@[UMShareToDouban, UMShareToTencent, UMShareToRenren]
                                           delegate:nil];
    }];
}

static BOOL flag = NO;

- (void)setupHeaderView {
    
    NSString *imageStr = self.data.albums[0];
    
    CKStepHeaderView *headerView = [[CKStepHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width*9/16 + 100)];
    
    headerView.ingredientsLabel.text = self.data.ingredients;
    
    headerView.burdeningLabel.text = self.data.burden;
    
    [headerView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    headerView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    __weak typeof(self) wself = self;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        flag = !flag;
        if (flag) {
            [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
            [UIView setAnimationDuration:0.5f];//动画时间
            headerView.imageView.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
            CGRect rect = headerView.imageView.frame;
            rect.origin.y = 0;
            headerView.imageView.frame = rect;
            [UIView commitAnimations]; //启动动画
        }
        if (!flag) {
            [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
            [UIView setAnimationDuration:0.5f];
            headerView.imageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);//将要显示的view按照正常比例显示出来
            CGRect rect = headerView.imageView.frame;
            rect.origin.y = 0;
            headerView.imageView.frame = rect;
            [UIView commitAnimations];
        }
        
    }];
    
    [headerView addGestureRecognizer:tapGR];
    
    self.ckImageView = headerView.imageView;
    
    self.tableView.tableHeaderView = headerView;
}


#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.stepsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CKStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.step = self.stepsArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}
@end
