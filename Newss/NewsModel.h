//
//  NewsModel.h
//  Newss
//
//  Created by xingJH on 14-8-29.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
//标题
@property (nonatomic,copy)NSString *newsTitle;
//描述
@property (nonatomic,copy) NSString *newsInfo;

//图片地址
@property (nonatomic,copy) NSString *newsImageStr;
//新闻唯一标识
@property (nonatomic,copy) NSString *newsId;

@end
