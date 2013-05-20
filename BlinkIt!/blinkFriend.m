//
//  blinkFriend.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/18/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "blinkFriend.h"

@implementation blinkFriend

@synthesize name = _name;
@synthesize memberId = _memberId;

-(id)initWithDictionary:(NSDictionary *) dic
{
    self = [super init];
    if(self){
        if([dic objectForKey:@"name"] && [dic objectForKey:@"id"]){
            _name = [dic objectForKey:@"name"];
            _memberId = [[dic objectForKey:@"id"] integerValue];
        }
    }
    
    return self;
}

-(NSString*) memberIdAsString
{
    return [NSString stringWithFormat:@"%d", _memberId];
}

@end
