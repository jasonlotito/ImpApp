//
//  blinkMe.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/17/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "blinkMe.h"

@implementation blinkMe

@synthesize memberId = _memberId;
@synthesize name = _name;
@synthesize sessionId = _sessionId;

static blinkMe *sharedInstance = nil;

+ (blinkMe *)meWithName:(NSString*)name memberId:(NSInteger)memberId sessionId:(NSString*)sessionId
{
    //  Static local predicate must be initialized to 0
//    static blinkMe *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[blinkMe alloc] init];
        // Do any other initialisation stuff here
        [sharedInstance setMemberId:memberId];
        [sharedInstance setName:name];
        [sharedInstance setSessionId:sessionId];
    });
    return sharedInstance;
}

+(blinkMe*)me
{
    return sharedInstance;
}

-(NSString*) memberIdAsString
{
    return [NSString stringWithFormat:@"%d", _memberId];
}


@end
