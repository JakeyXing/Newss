//
//  JHHRequestManager.h
//  Newss
//
//  Created by xingJH on 14-8-28.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHHRequestManager : NSObject

+(JHHRequestManager*)shareManager;

-(void)setRequest:(id)object key:(NSString*)urlString;

-(void)removeRequestWithKey:(NSString*)urlString;


@end
