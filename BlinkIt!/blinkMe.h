//
//  blinkMe.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/17/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface blinkMe : NSObject

+(blinkMe*) meWithName:(NSString*)name memberId:(NSInteger)memberId sessionId:(NSString*)sessionId;
+(blinkMe*)me;
-(NSString*) memberIdAsString;

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger memberId;
@property (strong, nonatomic) NSString *sessionId;


@end
