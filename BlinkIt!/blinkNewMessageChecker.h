//
//  blinkNewMessageChecker.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/16/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface blinkNewMessageChecker : NSObject
{
    NSInteger forMember;
    NSInteger fromMember;
}

@property (nonatomic) NSInteger forMember;
@property (nonatomic) NSInteger fromMember;

-(void)activelyCheckForMessagesForMember:(NSInteger)forMember fromMember:(NSInteger)fromMember;
-(void)stopCheckingMessages;

@end
