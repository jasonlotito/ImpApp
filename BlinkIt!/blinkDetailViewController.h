//
//  blinkDetailViewController.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/15/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blinkDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
