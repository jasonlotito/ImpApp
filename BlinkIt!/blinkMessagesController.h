//
//  blinkMessagesController.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/17/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blinkMessagesController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *messages;
}

@property (strong, nonatomic) NSMutableArray *messages;
@end
