//
//  JHHttpRequest.m
//  Newss
//
//  Created by xingJH on 14-8-28.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "JHHttpRequest.h"
#import "JHHRequestManager.h"
@implementation JHHttpRequest
{
    NSURLConnection *_urlConnection;
}

- (id)init{
    self = [super init];
    if (self) {
        _downloadData = [[NSMutableData alloc] init];
        
    }
    return self;
}

+ (JHHttpRequest *)requestWithUrlString:(NSString *)urlStr target:(id)target action:(SEL)action{
    JHHttpRequest *request = [[JHHttpRequest alloc] init];
    request.requestUrlString = urlStr;
    request.target = target;
    request.action = action;
    [request startRequest];
    [[JHHRequestManager shareManager] setRequest:request key:urlStr];
    return request;
}

- (void)startRequest{
    if (_requestUrlString.length == 0) {
        return;
    }
    NSURL *url = [NSURL URLWithString:_requestUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

#pragma mark - NSUrlConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_downloadData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_downloadData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [[JHHRequestManager shareManager] removeRequestWithKey:_requestUrlString];
    if ([_target respondsToSelector:_action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_action withObject:self];
#pragma clang diagnostic pop
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error!!");
}

@end
