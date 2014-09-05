//
//  NewsViewController.m
//  Newss
//
//  Created by xingJH on 14-8-15.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "NewsViewController.h"
#import "NavButtonModel.h"
#import "JHHttpRequest.h"
#import "UIImageView+WebCache.h"
#import "GDataXMLNode.h"
#import "DEFINE.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "MJRefresh.h"
#import "CustomTabBarUp.h"
enum {
    loadHeader = 0,
    loadFooter
};
@interface NewsViewController ()
{
    NSMutableArray *_dataArray;
    NSInteger _pn;
    NSInteger _load;
    NSInteger _type;
}
@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CustomTabBarUp *customTabBar = [[CustomTabBarUp alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    customTabBar.delegate = self;
    [self.view addSubview:customTabBar];
    _tableView.frame = CGRectMake(0, 44, 320, [Custom currentScreenHeight] - 44 - 64-40);
    
    _pn = 1;
    _load = loadHeader;
    _type = toutiao;
    _dataArray = [[NSMutableArray alloc] init];
    [self addTitleViewWithTitle:@"和讯新闻"];
    [self loadNewsDataWithPage:1];
    
    [self setupRefresh];
    
    
    
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];

    //[_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    _pn = 1;
    [self loadNewsDataWithPage:_pn];
    _load = loadHeader;
}

- (void)footerRereshing
{
    _pn++;
    [self loadNewsDataWithPage:_pn];
    _load = loadFooter;
}


#pragma mark - loadNewsDataWithPage
- (void)loadNewsDataWithPage:(NSInteger)pn{
    [JHHttpRequest requestWithUrlString:[NSString stringWithFormat:NewsUrlString,_type,pn] target:self action:@selector(requestFinished:)];
}

- (NSString*)getValueWithElement:(GDataXMLElement*)element childName:(NSString*)name{
    NSArray *array = [element elementsForName:name];
    GDataXMLElement *child = [array lastObject];
    return child.stringValue;
}

-(void)requestFinished:(JHHttpRequest*)request{
    if (request.downloadData) {
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:request.downloadData options:0 error:nil];
        NSArray *array = [doc nodesForXPath:@"//news" error:nil];
        
        if (_load == loadHeader) {
            [_dataArray removeAllObjects];
        }
        for (GDataXMLElement *news in array) {
            NSString *newsTitle = [self getValueWithElement:news childName:@"title"];
            NSString *newsInfo = [self getValueWithElement:news childName:@"abstract"];
            NSString *newsImageStr = [self getValueWithElement:news childName:@"img"];
            NSString *newsId = [self getValueWithElement:news childName:@"id"];
            NewsModel *model = [[NewsModel alloc] init];
            model.newsTitle = newsTitle;
            model.newsInfo = newsInfo;
            model.newsImageStr = newsImageStr;
            model.newsId = newsId;
            
            [_dataArray addObject:model];
            model = nil;
            
            
        }
        [_tableView reloadData];
        if (_load == loadHeader) {
            [_tableView headerEndRefreshing];
        }
        if (_load == loadFooter) {
            [_tableView footerEndRefreshing];
        }
        
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"News";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NewsModel *model = [_dataArray objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:0] lastObject];
    }
    
    if (model.newsImageStr.length >1) {
        cell.newsImage.hidden = NO;
        cell.newsInfo.frame = CGRectMake(20, 39, 188, 53);
        cell.newsImage.frame = CGRectMake(227, 38, 81, 58);
        NSArray *images = [model.newsImageStr componentsSeparatedByString:@"|"];
        if (images.count) {
            NSString *newsImageStr = [images objectAtIndex:0];
            [cell.newsImage sd_setImageWithURL:[NSURL URLWithString:newsImageStr]];
        }

    }else{
        cell.newsImage.hidden = YES;
        cell.newsInfo.frame = CGRectMake(20,39,290,53);
    }

    cell.newsTiltle.text = model.newsTitle;
    cell.newsInfo.text = model.newsInfo;
    
    //[cell downImage:model.newsImageStr];
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - customTabBarDelegate
- (void)customTabBarUp:(CustomTabBarUp *)tabBar didSelectedIndex:(NSInteger)index{
    NSLog(@"代理方法 %d",index);
    if (index ==0) {
        _type = toutiao;
    }
    if (index == 1) {
        _type = xinwen;
    }
    if (index == 2) {
        _type = gupiao;
    }
    _load = loadHeader;
    [self loadNewsDataWithPage:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
