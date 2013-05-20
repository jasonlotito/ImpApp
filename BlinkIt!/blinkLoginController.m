//
//  blinkLoginController.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/17/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "blinkLoginController.h"
#import "blinkHttp.h"
#import "blinkMasterViewController.h"
#import "blinkMessagesController.h"
#import "blinkProfileViewController.h"
#import "blinkMe.h"
#import "blinkNav.h"

@interface blinkLoginController ()

@end

@implementation blinkLoginController

@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _password.secureTextEntry = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Validation

-(BOOL)isUsernamePasswordFilledIn
{
    return ! ([_password.text isEqual:@""] || [_username.text isEqual:@""]);
}

#pragma UI Event Handlers

-(IBAction)loginButtonPressed
{
    if([self isUsernamePasswordFilledIn])
    {
        [self textFieldDoneEditing:_username];
        [self textFieldDoneEditing:_password];
        [self textFieldShouldReturn:_password];
//        [self performLogin];
    }
}

-(void)performLogin
{
    if([self isUsernamePasswordFilledIn])
    {
        NSString *url = [NSString stringWithFormat:@"%@/login?username=%@&password=%@",
                         BASE_URL,
                         [blinkHttp urlEncode:_username.text],
                         [blinkHttp urlEncode:_password.text]];
        NSLog(@"Hitting login server now... %@", url);
        [blinkHttp syncGetUrl:url withSelector:@selector(loginNow:) onObject:self];
    }
}

-(void)loginNow:(NSData*)data
{
    NSDictionary *json;
    parseJSON(json, data);
    

    if([[json objectForKey:@"success"]boolValue]){
        NSDictionary *userData = [json objectForKey:@"data"];
        NSInteger memberId = [[userData objectForKey:@"id"] integerValue];
        NSLog(@"Login successful");
        [blinkMe meWithName:_username.text memberId:memberId sessionId:[NSString stringWithFormat:@"%d",memberId]];
        [self resetInputs];
        [self moveToLoggedInScreen];
    } else {
        _error.text = @"Failed Login";
        NSLog(@"Failed login");
        [_username becomeFirstResponder];
    }
    
}

-(void)moveToLoggedInScreen
{
//    blinkLoginController *loginController = [[blinkLoginController alloc]initWithNibName:@"blinkLoginController" bundle:nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];

    
    blinkMasterViewController *masterController = [[blinkMasterViewController alloc]initWithNibName:@"blinkMasterViewController" bundle:nil];
    UINavigationController *masterNavController = [[UINavigationController alloc] initWithRootViewController:masterController];
    masterController.managedObjectContext = self.managedObjectContext;
    masterController.tabBarItem.image = [UIImage imageNamed:@"Social.png"];
    masterController.navigationController.navigationBar.tintColor = COLOR_LOGO_GREEN_DARK;
    masterController.navigationController.navigationBar.backgroundColor = COLOR_LOGO_GREEN_DARK;

    
    blinkMessagesController *messagesController = [[blinkMessagesController alloc]initWithNibName:@"blinkMessagesController" bundle:nil];
    UINavigationController *messagesNavController = [[UINavigationController alloc]initWithRootViewController:messagesController];
    messagesController.title = @"Messages";
    messagesController.tabBarItem.image = [UIImage imageNamed:@"Comment-1.png"];
    messagesController.navigationController.navigationBar.tintColor = COLOR_LOGO_BLUE_DARK;
    
    
    UIStoryboard *profileStoryboard = [UIStoryboard storyboardWithName:@"blinkProfileViewController" bundle:nil];
    blinkProfileViewController *profileViewController = (blinkProfileViewController*)[profileStoryboard instantiateViewControllerWithIdentifier:@"blinkProfileViewController"];
    UINavigationController *profileNavController = [[UINavigationController alloc]initWithRootViewController:profileViewController];
    profileViewController.tabBarItem.image = [UIImage imageNamed:@"Avatar.png"];
    profileViewController.title = @"Profile";
    
    
    [tabBarController addChildViewController:masterNavController];
    [tabBarController addChildViewController:messagesNavController];
    [tabBarController addChildViewController:profileNavController];
    tabBarController.tabBar.tintColor = COLOR_BLACK;
    
    
    [self presentViewController:tabBarController animated:YES completion:nil];
}

-(void)resetInputs
{
    [self textFieldDoneEditing:_username];
    [self textFieldDoneEditing:_password];
    _username.text = @"";
    _password.text = @"";
}

-(IBAction)signupButtonPressed
{
    if([self isUsernamePasswordFilledIn])
    {
        [self textFieldDoneEditing:_username];
        [self textFieldDoneEditing:_password];
        [self createAccount];
    }
}

#pragma Keyboard Handlers

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"testFieldShouldReturn");
    if (textField == _username) {
        [textField resignFirstResponder];
        NSLog(@"Password become first responder");
        [_password becomeFirstResponder];
        return NO;
    } else if (textField == _password) {
        NSLog(@"Perform login");
        [self performLogin];
    }
    return YES;
}

-(void)createAccount
{
    NSString *url = [NSString stringWithFormat:@"%@/addMember?username=%@&password=%@",
                        BASE_URL,
                        [blinkHttp urlEncode:_username.text],
                        [blinkHttp urlEncode:_password.text]];
    
    [blinkHttp syncGetUrl:url withSelector:@selector(performLogin) onObject:self];
}

-(IBAction) textFieldDoneEditing : (id) sender
{
//    [sender resignFirstResponder];
}

-(void)keyboardWillShow:(NSNotification*) aNotification {
    NSLog(@"Keyboard was shown");
    NSDictionary* info = [aNotification userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    // Move
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    NSLog(@"frame..%f..%f..%f..%f",self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"keyboard..%f..%f..%f..%f",keyboardFrame.origin.x, keyboardFrame.origin.y, keyboardFrame.size.width, keyboardFrame.size.height);
    [self.view setFrame:CGRectMake(
                                   self.view.frame.origin.x,
                                   self.view.frame.origin.y - (keyboardFrame.size.height - 60),
                                   self.view.frame.size.width,
                                   self.view.frame.size.height)];

    
    
    NSLog(@"frame..%f..%f..%f..%f",self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"keyboard..%f..%f..%f..%f",keyboardFrame.origin.x, keyboardFrame.origin.y, keyboardFrame.size.width, keyboardFrame.size.height);
    
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification*) aNotification {
    NSLog(@"Keyboard will hide");
    NSDictionary* info = [aNotification userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    // Move
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [self.view setFrame:CGRectMake(
                                   self.view.frame.origin.x,
                                   self.view.frame.origin.y +
                                    (keyboardFrame.size.height - 60),
                                   self.view.frame.size.width,
                                   self.view.frame.size.height)];
    [UIView commitAnimations];
}

#pragma View Handlers


- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
