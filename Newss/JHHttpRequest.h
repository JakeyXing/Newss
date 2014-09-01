//
//  JHHttpRequest.h
//  Newss
//
//  Created by xingJH on 14-8-28.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHHttpRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic,copy) NSString *requestUrlString;

@property (nonatomic,strong) NSMutableData *downloadData;
@property (nonatomic,weak) id target;
@property (nonatomic,assign) SEL action;


+(JHHttpRequest*)requestWithUrlString:(NSString*)urlStr target:(id)target action:(SEL)action;

@end
