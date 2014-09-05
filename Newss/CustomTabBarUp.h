//
//  CustomTabBarUp.h
//  Newss
//
//  Created by xingJH on 14-9-5.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CustomTabBarUp;
@protocol CustomTabBarUpDelegate <NSObject>

//告知外部，选中的是哪个按钮
- (void)customTabBarUp:(CustomTabBarUp*)tabBar didSelectedIndex:(NSInteger)index;

@end

@interface CustomTabBarUp : UIView
@property (nonatomic,assign)id <CustomTabBarUpDelegate>delegate;
@end
