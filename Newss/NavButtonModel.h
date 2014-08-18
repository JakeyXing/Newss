//
//  NavButtonModel.h
//  Newss
//
//  Created by xingJH on 14-8-15.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavButtonModel : NSObject

@property (nonatomic,copy)NSString *imageName;
@property (nonatomic,assign) SEL action;
@property (nonatomic,assign) BOOL isLeft;

@end
