//
//  blinkHttp.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/17/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "blinkHttp.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

@implementation blinkHttp

+(void)getUrl:(NSString *)url withSelector:(SEL)aSelector onObject:(id)obj andWait:(BOOL)wait
{
    NSLog(@"blinkHttp::get > %@", url);
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:url]];
        
        [obj performSelectorOnMainThread:aSelector
                               withObject:data waitUntilDone:wait];
    });
}

+(void)asyncGetUrl:(NSString *)url withSelector:(SEL)aSelector onObject:(id)obj
{
    [self getUrl:url withSelector:aSelector onObject:obj andWait:NO];
}

+(void)syncGetUrl:(NSString *)url withSelector:(SEL)aSelector onObject:(id)obj
{
    [self getUrl:url withSelector:aSelector onObject:obj andWait:YES];
}

+(NSString *)urlEncode:(NSString*)param
{
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)param,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
}
@end
