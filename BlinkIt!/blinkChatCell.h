//
//  blinkChatCell.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/16/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blinkChatCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *message;
@property (strong, nonatomic) IBOutlet UILabel *name;

@end
