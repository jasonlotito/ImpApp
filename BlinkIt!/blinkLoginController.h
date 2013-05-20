//
//  blinkLoginController.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/17/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface blinkLoginController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UILabel *error;
@property (weak, nonatomic) IBOutlet UIButton *signup;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
