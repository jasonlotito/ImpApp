//
//  blinkFriend.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/18/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface blinkFriend : NSObject
{
    NSString *name;
    NSInteger memberId;
}

-(id)initWithDictionary:(NSDictionary *) dic;
-(NSString*) memberIdAsString;

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger memberId;

@end
