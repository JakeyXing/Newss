//
//  CustomTabBarController.m
//  Newss
//
//  Created by xingJH on 14-8-15.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "CustomTabBarController.h"
#import "RootViewController.h"
#import "Custom.h"
@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

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
    [self createControllers];
    [self createCustomTabBar];
}


- (void)createControllers{
    NSArray *controllersName = [NSArray arrayWithObjects:@"NewsViewController",@"MarketViewController",@"VideoViewController",@"PictureViewController",@"SettingViewController", nil];
    NSMutableArray *controllers = [NSMutableArray array];
    for (int i = 0; i<controllersName.count; i++) {
        NSString *name = [controllersName objectAtIndex:i];
        Class class = NSClassFromString(name);
        RootViewController *vc = [[class alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:nav];
    }
    self.viewControllers = controllers;
}

- (void)createCustomTabBar{
    self.tabBar.hidden = YES;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tabBar" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    CustomTabBar *tabBar = [[CustomTabBar alloc] initWithFrame:CGRectMake(0, [Custom currentScreenHeight]-44, 320, 44) tabBarDic:dic];
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
}

#pragma mark - CustomTabBarDelegate
- (void)customTabBar:(CustomTabBar *)tabBar didSelectedIndex:(NSInteger)index{
    self.selectedIndex = index;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
