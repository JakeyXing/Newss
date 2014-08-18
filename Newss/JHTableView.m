//
//  JHTableView.m
//  Newss
//
//  Created by xingJH on 14-8-14.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "JHTableView.h"
#import <QuartzCore/QuartzCore.h>

#define kTableView_Tag 2013
#define kTableView_ContentView_Tag 1234

@interface JHTableView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    CGSize _size;
    
}

- (void)createTableView;

@end

@implementation JHTableView

@synthesize tableView = _tableView;
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize currentIndex = _currentIndex;
@synthesize pagingEnabled = _pagingEnabled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _size = frame.size;
        self.currentIndex = -1;
        [self createTableView];
    }
    return self;
}

#pragma mark - Private Method
- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _size.width, _size.height)];
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.tag = kTableView_Tag;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_tableView];
}

#pragma mark - Public Method
- (void)reloadData{
    _size = self.frame.size;
    _tableView.frame = CGRectMake(0, 0, _size.width, _size.height);
    [_tableView reloadData];
}

- (void)setPagingEnabled:(BOOL)pagingEnabled{
    if (_pagingEnabled != pagingEnabled) {
        _pagingEnabled = pagingEnabled;
        _tableView.pagingEnabled = _pagingEnabled;
    }
}

- (UIView*)getViewInJHTableViewWithIndex:(NSInteger)index{
    return nil;
}
-(UITableView *)tableView{
    return (UITableView*)[self viewWithTag:kTableView_Tag];
}

- (void)JHTableScrollToIndex:(NSInteger)index animation:(BOOL)animation{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:animation];
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataSource respondsToSelector:@selector(JHTableView:widthForIndex:)]) {
        return [self.dataSource JHTableView:self widthForIndex:indexPath.row];
    }else{
        return 0.f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataSource respondsToSelector:@selector(numberOfIndexForJHTableView:)]) {
        return [self.dataSource numberOfIndexForJHTableView:self];
    }
    else {
        return 0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"JHTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.frame = CGRectMake(0, 0, [self.dataSource JHTableView:self widthForIndex:indexPath.row], _size.height);
        cell.contentView.frame = cell.bounds;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = [self.dataSource JHTableView:self targetRect:cell.contentView.frame ForIndex:indexPath.row];
        if (!contentView) {
            contentView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
            
        }
        contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        contentView.frame = CGRectMake(0, 0, cell.contentView.frame.size.height, cell.contentView.frame.size.width);
        contentView.tag = kTableView_ContentView_Tag;
        [cell.contentView addSubview:contentView];
    }
    cell.frame = CGRectMake(0, 0, [self.dataSource JHTableView:self widthForIndex:indexPath.row], _size.height);
    cell.contentView.frame = cell.bounds;
    UIView *contentView = [cell.contentView viewWithTag:kTableView_ContentView_Tag];
    contentView.frame = CGRectMake(0, 0, cell.contentView.frame.size.height, cell.contentView.frame.size.width);
    [self.dataSource JHTableView:self setContentView:contentView ForIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(JHTableView:selectIndex:)]) {
        [self.delegate JHTableView:self selectIndex:indexPath.row];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.pagingEnabled) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int currentPage = floor((scrollView.contentOffset.y - pageWidth/2)/pageWidth)+1;
        
        if (self.currentIndex != currentPage) {
            if ([self.delegate respondsToSelector:@selector(JHTableView:scrollToIndex:)]) {
                [self.delegate JHTableView:self scrollToIndex:currentPage];
            }
            self.currentIndex = currentPage;
        }
    }
    if ([self.delegate respondsToSelector:@selector(scrollToRefreshView)]) {
        [self.delegate scrollToRefreshView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.delegate respondsToSelector:@selector(JHTableViewDidEndDragging:)]) {
        [self.delegate JHTableViewDidEndDragging:_tableView];
    }
}




@end
