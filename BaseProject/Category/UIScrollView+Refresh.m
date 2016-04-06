//
//  UIScrollView+Refresh.m
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)

- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshBlock {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
}
- (void)beginHeaderRefresh {
    [self.mj_header beginRefreshing];
}
- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
}

- (void)addFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshBlock {
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshBlock];
}
- (void)beginFooterRefresh {
    [self.mj_footer beginRefreshing];
}
- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}


@end
