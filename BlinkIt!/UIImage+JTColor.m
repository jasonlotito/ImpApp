//
//  UIImage+JTColor.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/18/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "UIImage+JTColor.h"

@implementation UIImage (JTColor)
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
