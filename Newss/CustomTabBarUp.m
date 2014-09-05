//
//  CustomTabBarUp.m
//  Newss
//
//  Created by xingJH on 14-9-5.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "CustomTabBarUp.h"

@implementation CustomTabBarUp

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createButtons];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    }
    return self;
}


- (void)createButtons{
    NSArray *titleArr = @[@"头条",@"新闻",@"股票",@"基金",@"更多"];
    float space = (320-5*45)/6;
    for (int i = 0; i<5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
        btn.frame = CGRectMake(space+i*(45+space), 1, 45, 38);
        btn.tag = 100+i;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
}

- (void)btnClicked:(UIButton*)btn{
    NSLog(@"btn.tag=%d",btn.tag);
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *currentBtn = (UIButton*)view;
            if(currentBtn.tag == btn.tag){
                [currentBtn setBackgroundImage:[UIImage imageNamed:@"a2"] forState:UIControlStateNormal];
                [currentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                [currentBtn setBackgroundImage:nil forState:UIControlStateNormal];
                [currentBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
            }
        }
    }
    NSInteger index = btn.tag - 100;
    if ([_delegate respondsToSelector:@selector(customTabBarUp:didSelectedIndex:)]) {
        [_delegate customTabBarUp:self didSelectedIndex:index];
    }

}

@end
