//
//  Custom.h
//  Newss
//
//  Created by xingJH on 14-8-14.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Custom : NSObject

+ (NSInteger)currentScreenHeight;

+ (BOOL)isIos7Version;
//设备的类型
+ (NSString *)currentDeviceModel;

+(void)showAlert:(NSString *)message;
+(void)showAlertAfterRemove:(NSString *)message;


@end
