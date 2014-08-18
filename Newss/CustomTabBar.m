//
//  CustomTabBar.m
//  Newss
//
//  Created by xingJH on 14-8-15.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "CustomTabBar.h"

@implementation CustomTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame tabBarDic:(NSDictionary *)dic{
    self = [super initWithFrame:frame];
    if (self) {
        [self createTabBarWithDic:dic];
    }
    return self;
}


- (void)createTabBarWithDic:(NSDictionary*)dic{
    if (dic.allKeys.count == 0) {
        return;
    }
    NSArray *imageNames = [dic objectForKey:@"imageName"];
    NSArray *imageNamesH = [dic objectForKey:@"imageNameh"];
    
    CGFloat btnWidth = self.bounds.size.width/imageNames.count;
    CGFloat btnHeight = 44;
    for (int i =0; i<imageNames.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, btnHeight)];
        [btn setBackgroundImage:[UIImage imageNamed:[imageNames objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[imageNamesH objectAtIndex:i]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        if (i == 0) {
            btn.selected = YES;
        }
        [self addSubview:btn];
    }
}

- (void)btnClicked:(UIButton*)btn{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *currentBtn = (UIButton*)view;
            if(currentBtn.tag == btn.tag){
                currentBtn.selected = YES;
            }else{
                currentBtn.selected = NO;
            }
        }
    }
    NSInteger index = btn.tag - 100;
    if ([_delegate respondsToSelector:@selector(customTabBar:didSelectedIndex:)]) {
        [_delegate customTabBar:self didSelectedIndex:index];
    }
}
@end
