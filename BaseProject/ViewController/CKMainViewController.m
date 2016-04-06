//
//  ViewController.m
//  BaseProject
//
//  Created by tarena on 15/12/15.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CKMainViewController.h"
#import "CookbookNewManager.h"
#import "CookbookModel.h"
#import "CKCategory.h"
#import "WMTableViewController.h"
#import "WMLoopView.h"
#import "CKTableViewCell.h"
#import "CKStepsViewController.h"

@interface CKMainViewController ()<UITableViewDataSource,UITableViewDelegate,WMLoopViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
/**
 *  返回值起始下标
 */
@property (nonatomic, assign) NSInteger pn;

@end

static NSString *const identifier = @"CKCell";

@implementation CKMainViewController

#pragma mark - Lazy initialization

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 110;
        [self.view addSubview:_tableView];
        [_tableView registerNib:[UINib nibWithNibName:@"CKTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image1 = [UIImage imageNamed:@"icon_homepage"];
    UIImage *image2 = [UIImage imageNamed:@"icon_homepage_highlighted"];
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:image1 selectedImage:image2];
    self.title = @"今日食谱";
    self.navigationController.title = @"主页";
    
//    self.fd_prefersNavigationBarHidden = YES;
    [self setupHeaderView];
    
    self.pn = 0;
    self.tableView.hidden = NO;
    
    [self loadNewMenus];
    
    __weak id weakself = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"------------beginRefreshing");
        [weakself loadMoreMenus];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 加载菜谱

- (void)loadNewMenus {
    self.pn = 0;
    [CookbookNewManager getMenuWithCid:102 withPn:self.pn completionHandle:^(id model, NSError *error) {
        if (error) {
            NSLog(@"getMenuError = %@",error.userInfo);
            
        } else {
            NSLog(@"model = %@", model);
        }
        CookbookModel *cookbook = model;
        Result *result = cookbook.result;
        self.dataArray = [result.data mutableCopy];
        [self.tableView reloadData];
    }];
}
- (void)loadMoreMenus {
    self.pn += 10;
    [CookbookNewManager getMenuWithCid:102 withPn:self.pn completionHandle:^(id model, NSError *error) {
        if (error) {
            NSLog(@"getMenuError = %@",error.userInfo);
        }
        CookbookModel *cookbook = model;
        Result *result = cookbook.result;
        [self.dataArray addObjectsFromArray:result.data];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"------------endRefreshing");
    }];
}

#pragma mark - 设置表头

- (void)setupHeaderView {
    
    NSArray *images = @[@"2.jpg",@"4.jpg"];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    WMLoopView *loopView = [[WMLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.8) images:images autoPlay:YES delay:4.0];
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
}

#pragma mark - UITableViewDataSouce & UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    Data *data = self.dataArray[indexPath.row];
    
    cell.data = data;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger selectedRow = tableView.indexPathForSelectedRow.row;
    Data *data = self.dataArray[selectedRow];
    
    CKStepsViewController *stepViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VVC"];
    
    stepViewController.data = data;
    stepViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
//    [self presentViewController:stepViewController animated:YES completion:nil];
    [self.navigationController pushViewController:stepViewController animated:YES];

}


@end
