//
//  blinkNav.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/18/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "blinkNav.h"

@implementation blinkNav

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIColor *color = [UIColor blueColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(context, CGColorGetComponents( [color CGColor]));
    CGContextFillRect(context, rect);
}

@end
