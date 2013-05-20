//
//  blinkProfileViewController.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/18/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "blinkMe.h"

@interface blinkProfileViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *emailCell;

@property (strong, nonatomic) blinkMe *me;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property (strong, nonatomic) IBOutlet UILabel *profileEmail;
@property (strong, nonatomic) IBOutlet UILabel *profileId;

@end
