//
//  UIScrollView+Refresh.h
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refresh)

- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshBlock;
- (void)beginHeaderRefresh;
- (void)endHeaderRefresh;

- (void)addFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshBlock;
- (void)beginFooterRefresh;
- (void)endFooterRefresh;

@end
