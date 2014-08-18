//
//  RootViewController.m
//  Newss
//
//  Created by xingJH on 14-8-13.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "RootViewController.h"
#import "Custom.h"
#import "NavButtonModel.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navibarbackground.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger height = 0;
    if ([Custom isIos7Version] == YES) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        height = 64;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, height, 320, [Custom currentScreenHeight] - 44 - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource  = self;
    [self.view addSubview:_tableView];
    
}


- (void)addTitleViewWithTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
}

- (void)addItemWithArray:(NSArray *)array{
    if (array.count == 0) {
        return;
    }
    NSMutableArray *items = [NSMutableArray array];
    int i = 100;
    for (NavButtonModel *model in array) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:model.imageName] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(0, 0, 30, 30)];
        [btn addTarget:self action:model.action forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        i++;
    }
    NavButtonModel *model = [array lastObject];
    if (model.isLeft == YES) {
        self.navigationItem.leftBarButtonItems = items;
    }else{
        self.navigationItem.rightBarButtonItems = items;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
