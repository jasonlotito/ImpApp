//
//  blinkDetailViewController.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/15/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "blinkFriend.h"


@interface blinkDetailViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate>
{
    NSMutableArray *chatData;
    NSMutableData *responseData;
}

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) blinkFriend *person;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *chat;
@property (weak, nonatomic) IBOutlet UITableView *chatView;
@property (nonatomic, strong) NSMutableArray *chatData;
@property (strong, nonatomic) NSMutableData *responseData;
@end
