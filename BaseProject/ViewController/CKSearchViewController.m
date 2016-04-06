//
//  CKSearchViewController.m
//  BaseProject
//
//  Created by tarena on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CKSearchViewController.h"
#import "CookbookNewManager.h"
#import "CookbookModel.h"
#import "CKTableViewCell.h"
#import "CKStepsViewController.h"
@interface CKSearchViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *reslutsArray;

@end
static NSString *const identifier = @"CKCell";
@implementation CKSearchViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        UIImage *image1 = [UIImage imageNamed:@"icon_search"];
        UIImage *image2 = [UIImage imageNamed:@"icon_search_highlighted"];
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"查找" image:image1 selectedImage:image2];
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"CKTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 110;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.fd_prefersNavigationBarHidden = YES;
    self.tableView.hidden = NO;
    self.navigationItem.title = @"查找";
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 44)];
    searchBar.placeholder = @"请输入菜名";
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    searchBar.showsScopeBar = YES;
    searchBar.delegate = self;
    
    self.tableView.tableHeaderView = searchBar;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - TableViewDelegate & TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"search reslut: %ld", self.reslutsArray.count);
    return self.reslutsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Data *data = self.reslutsArray[indexPath.row];
    
    CKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.data = data;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger selectedRow = tableView.indexPathForSelectedRow.row;
    Data *data = self.reslutsArray[selectedRow];
    
    CKStepsViewController *stepViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VVC"];
    
    stepViewController.data = data;
    stepViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.navigationController pushViewController:stepViewController animated:YES];
}

#pragma mark - UISearBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"text: %@", searchBar.text);
    
    [self loadNewMenusWithName:searchBar.text];
    
    __weak id weakself = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"------------beginRefreshing");
        [weakself loadMoreMenusWithName:searchBar.text];
    }];
    
    [self.view endEditing:YES];
}

static int pn = 0;

- (void)loadNewMenusWithName:(NSString *)name {
    [CookbookNewManager getMenuWithMenuName:name pn:pn completionHandle:^(id model, NSError *error) {
        NSLog(@"search complete");
        if (error) {
            NSLog(@"search error: %@", error.userInfo);
        } else {
            CookbookModel *cookbook = model;
            self.reslutsArray = [cookbook.result.data mutableCopy];
            [self.tableView reloadData];
        }
    }];
}

- (void)loadMoreMenusWithName:(NSString *)name {
    pn += 10;
    [CookbookNewManager getMenuWithMenuName:name pn:pn completionHandle:^(id model, NSError *error) {
        CookbookModel *cookbook = model;
        [self.reslutsArray addObjectsFromArray:cookbook.result.data];
        [self.tableView reloadData];
        [self.tableView endFooterRefresh];
        NSLog(@"------------endRefreshing");
    }];
}




@end
