//
//  blinkNewMessageChecker.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/16/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "blinkNewMessageChecker.h"

@implementation blinkNewMessageChecker

@synthesize forMember = _forMember;
@synthesize fromMember = _fromMember;

-(void)checkForMessagesForMember:(NSInteger)forMember fromMember:(NSInteger)fromMember
{
    [self setForMember:forMember];
    [self setFromMember:fromMember];
}

-(void)stopCheckingMessages
{
    
}

@end
