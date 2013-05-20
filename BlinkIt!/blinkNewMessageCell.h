//
//  blinkNewMessageCell.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/17/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blinkNewMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *senderImage;
@property (weak, nonatomic) IBOutlet UILabel *senderName;
@property (weak, nonatomic) IBOutlet UILabel *messageSent;

@end
