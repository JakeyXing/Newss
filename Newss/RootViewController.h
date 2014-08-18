//
//  RootViewController.h
//  Newss
//
//  Created by xingJH on 14-8-13.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
}

- (void)addTitleViewWithTitle:(NSString*)title;
- (void)addItemWithArray:(NSArray*)array;

@end
