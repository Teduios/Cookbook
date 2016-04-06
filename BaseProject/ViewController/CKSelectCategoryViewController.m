//
//  CKSelectCategoryViewController.m
//  BaseProject
//
//  Created by tarena on 15/12/23.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CKSelectCategoryViewController.h"
#import "CookbookNewManager.h"
#import "CKSubCategoryViewController.h"
@interface CKSelectCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArray;

@end

static NSString *const identifier = @"CKCategoryCell";

@implementation CKSelectCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.tableFooterView = [UIView new];
    
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"category.db"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        FMResultSet *resultSet = [db executeQueryWithFormat:@"select * from subcategory where kind = %@", self.listName];
        while ([resultSet next]) {
            NSString *name = [resultSet stringForColumn:@"title"];
            NSString *parentId = [resultSet stringForColumn:@"ID"];
            CKList *list = [CKList new];
            list.name = name;
            list.ID = parentId;
            [self.listArray addObject:list];
        }
    }
    [db close];
    
    [self.tableView reloadData];

}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    CKList *list = self.listArray[indexPath.row];
    cell.textLabel.text = list.name;
    NSLog(@"listName: %@", list.name);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger selectedRow = self.tableView.indexPathForSelectedRow.row;
    CKList *list = self.listArray[selectedRow];
    NSInteger cid = [list.ID integerValue];
    NSLog(@"selected cid = %ld",cid);
    
    CKSubCategoryViewController *subCategoryVC = [self.storyboard instantiateViewControllerWithIdentifier:CKSubcategoryViewControllerIdentifier];
    subCategoryVC.cid = cid;
    subCategoryVC.name = list.name;
    [self.navigationController pushViewController:subCategoryVC animated:YES];
    
}

- (NSMutableArray *)listArray {
	if(_listArray == nil) {
		_listArray = [[NSMutableArray alloc] init];
	}
	return _listArray;
}

@end
