//
//  CKSubCategoryViewController.m
//  BaseProject
//
//  Created by tarena on 15/12/23.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CKSubCategoryViewController.h"
#import "CKTableViewCell.h"
#import "CKStepsViewController.h"
#import "UMSocial.h"
#import "CookbookNewManager.h"
@interface CKSubCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *const identifier = @"CKCell";

NSString * CKSubcategoryViewControllerIdentifier = @"SubCategory";

@implementation CKSubCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.fd_prefersNavigationBarHidden = NO;
    
    self.navigationItem.title = self.name;
    self.tableView.rowHeight = 110;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"CKTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    [self loadNewMenus];
    
    __weak id weakself = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"------------beginRefreshing");
        [weakself loadMoreMenus];
    }];
}

static int pn = 0;

- (void)loadNewMenus {
    [CookbookNewManager getMenuWithCid:_cid withPn:pn completionHandle:^(id model, NSError *error) {
        CookbookModel *cookbook = model;
        self.dataArray = [cookbook.result.data mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)loadMoreMenus {
     pn += 10;
    [CookbookNewManager getMenuWithCid:_cid withPn:pn completionHandle:^(id model, NSError *error) {
        CookbookModel *cookbook = model;
        [self.dataArray addObjectsFromArray:cookbook.result.data];
        [self.tableView reloadData];
        [self.tableView endFooterRefresh];
        NSLog(@"------------endRefreshing");
    }];
}


#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.data = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger selectedRow = tableView.indexPathForSelectedRow.row;
    Data *data = self.dataArray[selectedRow];

    CKStepsViewController *stepViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VVC"];

    stepViewController.data = data;

//    [self presentViewController:stepViewController animated:YES completion:nil];
    [self.navigationController pushViewController:stepViewController animated:YES];

}

@end
