//
//  CustomTabBar.h
//  Newss
//
//  Created by xingJH on 14-8-15.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <UIKit/UIKit.h>
//视图的封装  参考UIKIT中视图的封装思想，将外部交互的内容，动作等，定义成delegate方法，供外部使用

@class CustomTabBar;
@protocol CustomTabBarDelegate <NSObject>

//告知外部，选中的是哪个按钮
- (void)customTabBar:(CustomTabBar*)tabBar didSelectedIndex:(NSInteger)index;

@end

@interface CustomTabBar : UIView
@property (nonatomic,weak) id <CustomTabBarDelegate>delegate;

- (id)initWithFrame:(CGRect)frame tabBarDic:(NSDictionary*)dic;



@end
