//
//  CKCategoryCollectionViewController.m
//  BaseProject
//
//  Created by tarena on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CKCategoryTableViewController.h"
#import "CookbookModel.h"
#import "CKCategory.h"
#import "CookbookNewManager.h"
#import "CKSubCategoryViewController.h"
#import "CKSelectCategoryViewController.h"

@interface CKCategoryTableViewController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic, copy) NSMutableArray *categoryArray;

@end

@implementation CKCategoryTableViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        UIImage *image1 = [UIImage imageNamed:@"icon_category_-1"];
        UIImage *image2 = [UIImage imageNamed:@"icon_category_highlighted_-1"];
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"分类" image:image1 selectedImage:image2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.navigationItem.title = @"分类";
    
    [self getCategoryData];
    
}
/**
 *  获取分类的数据
 */
- (void)getCategoryData {
    
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"category.db"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dbPath] == NO) {
        [CookbookNewManager getCategoryCompletionHandle:^(id model, NSError *error) {
            CKCategory *category = model;
            [category createDataBaseTable];
            [self readCategoricalDataWith:dbPath];
        }];
    } else {
        NSLog(@"分类数据已存在！ ");
        [self readCategoricalDataWith:dbPath];
    }
}
/**
 *  读取db文件中的分类数据
 *
 *  @param dbPath db文件的路径
 */
- (void)readCategoricalDataWith:(NSString *)dbPath {
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        FMResultSet *resultSet = [db executeQuery:@"select * from category"];
        while ([resultSet next]) {
            NSString *name = [resultSet stringForColumn:@"name"];
            NSLog(@"category name : %@", name);
            [self.categoryArray addObject:name];
        }
    }
    [db close];
    [self.tableView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor ghostWhite];
    
    cell.textLabel.text = self.categoryArray[indexPath.row];
    
    NSLog(@"category = %@", self.categoryArray[indexPath.row]);
    
    return cell;

}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CKSelectCategoryViewController *selectViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategory"];
    selectViewController.listName = self.categoryArray[indexPath.row];
    [self.navigationController pushViewController:selectViewController animated:YES];
}

- (NSMutableArray *)categoryArray {
	if(_categoryArray == nil) {
		_categoryArray = [[NSMutableArray alloc] init];
	}
	return _categoryArray;
}

@end
