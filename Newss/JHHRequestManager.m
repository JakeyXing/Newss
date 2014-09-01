//
//  JHHRequestManager.m
//  Newss
//
//  Created by xingJH on 14-8-28.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "JHHRequestManager.h"

@implementation JHHRequestManager
{
    NSMutableDictionary *_resutlDic;
}
static JHHRequestManager *manager = nil;

+(JHHRequestManager *)shareManager{
    if (manager == nil) {
        manager = [[JHHRequestManager alloc] init];
    }
    return manager;
}

- (id)init{
    self = [super init];
    if (self) {
        _resutlDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setRequest:(id)object key:(NSString *)urlString{
    if (object == nil) {
        return;
    }
    [_resutlDic setObject:object forKey:urlString];
}

- (void)removeRequestWithKey:(NSString *)urlString{
    [_resutlDic removeObjectForKey:urlString];
}

@end
