//
//  blinkHttp.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/17/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface blinkHttp : NSObject

+ (void) asyncGetUrl:(NSString *)url withSelector:(SEL)aSelector onObject:(id)obj;
+ (void) syncGetUrl:(NSString *)url withSelector:(SEL)aSelector onObject:(id)obj;
+ (NSString *) urlEncode:(NSString*)param;

@end
