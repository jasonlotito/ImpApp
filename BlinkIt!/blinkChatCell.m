//
//  blinkChatCell.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/16/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "blinkChatCell.h"

@implementation blinkChatCell

@synthesize message = _message;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
