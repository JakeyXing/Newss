//
//  JHTableView.h
//  Newss
//
//  Created by xingJH on 14-8-14.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHTableViewDataSource;
@protocol JHTableViewDelegate;

@interface JHTableView : UIView

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) id<JHTableViewDataSource> dataSource;
@property (nonatomic,weak) id<JHTableViewDelegate> delegate;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) BOOL pagingEnabled;

//刷新视图
- (void)reloadData;
//滚动到指定的内容视图
- (void)JHTableScrollToIndex:(NSInteger)index animation:(BOOL)animation;
//获取当前视图所处位置
-(UIView*)getViewInJHTableViewWithIndex:(NSInteger)index;


@end

@protocol JHTableViewDelegate <NSObject>

@optional
//选中某个视图时触发此方法
-(void)JHTableView:(JHTableView*)fanView selectIndex:(NSInteger)index;
//滚动到某一个视图时触发此方法
-(void)JHTableView:(JHTableView *)fanView scrollToIndex:(NSInteger)index;

//停止拖拽时触发此方法
-(void)JHTableViewDidEndDragging:(UITableView*)tableView;

//刷新当前视图，滚动时触发
- (void)scrollToRefreshView;
@end

@protocol JHTableViewDataSource <NSObject>

@required
//每个子视图的宽度
-(CGFloat)JHTableView:(JHTableView*)fanView widthForIndex:(NSInteger)index;
//视图的总数
-(NSInteger)numberOfIndexForJHTableView:(JHTableView*)fanView;
//为ContentView中的子视图控件重新赋值
-(void)JHTableView:(JHTableView*)fanView setContentView:(UIView*)contentView ForIndex:(NSInteger)index;
//根据指定的frame返回UIView实例作为子视图
-(UIView*)JHTableView:(JHTableView*)fanView targetRect:(CGRect)targetRect ForIndex:(NSInteger)index;

@end