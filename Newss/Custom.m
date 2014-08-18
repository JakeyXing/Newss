//
//  Custom.m
//  Newss
//
//  Created by xingJH on 14-8-14.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "Custom.h"

@implementation Custom


+ (NSInteger)currentScreenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (BOOL)isIos7Version{
    NSString *version = [UIDevice currentDevice].systemVersion;
    if ([version hasPrefix:@"7"]) {
        return YES;
    }
    return NO;
}
//设备的类型
+ (NSString *)currentDeviceModel{
    return [UIDevice currentDevice].model;
}


+(void)showAlert:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

+(void)showAlertAfterRemove:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    [self performSelector:@selector(hide:) withObject:alertView afterDelay:1.0];
}

+(void)hide:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    // or hide?
}


@end
