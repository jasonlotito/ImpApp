//
//  blinkDetailViewController.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/15/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "blinkDetailViewController.h"
#import "blinkChatCell.h"
#import "blinkHttp.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define TABBAR_HEIGHT 49.0f
#define TEXTFIELD_HEIGHT 70.0f
#define MAX_ENTRIES_LOADED 25

@interface blinkDetailViewController ()
- (void)configureView;
@end

@implementation blinkDetailViewController

@synthesize person = _person;
@synthesize phoneNumber = _phoneNumber;
@synthesize chat = _chat;
@synthesize chatView = _chatView;
@synthesize chatData = _chatData;
@synthesize responseData = _responseData;

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

-(IBAction) textFieldDoneEditing : (id) sender
{
    [sender resignFirstResponder];
    [_chat resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    if(textField.text.length>0){
        NSUInteger count = [_chatView numberOfRowsInSection:0];
        if ( count > 0 ) {
//            count--;
        }
//        count = 0;
        NSDictionary *message = @{@"text":textField.text, @"name":@"Jason"};
        textField.text = @"";
        [self insertNewMessage:message];
        
        NSString *url = [NSString stringWithFormat:@"%@/sendMessage?to=%@&from=%@&message=%@",
                         BASE_URL,
                         [_person memberIdAsString],
                         [[blinkMe me] memberIdAsString],
                         [blinkHttp urlEncode:message[@"text"]]];
        [blinkHttp syncGetUrl:url withSelector:nil onObject:nil];

    }
    
    return YES;
}

-(void) insertNewMessage:(NSDictionary*)message
{
    [_chatData addObject:message];
    
    NSUInteger count = [_chatView numberOfRowsInSection:0];
    
    NSMutableArray *insertIndexPath = [[NSMutableArray alloc] init];
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:count inSection:0];
    [insertIndexPath addObject:newPath];
    [_chatView beginUpdates];
    [_chatView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:UITableViewRowAnimationNone];
    [_chatView endUpdates];
    [_chatView reloadData];
    [_chatView setContentOffset:CGPointMake(0, _chatView.contentSize.height - _chatView.frame.size.height) animated:YES];
}

-(NSString *)urlEncodeUsingEncoding:(NSString*)param {
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (__bridge CFStringRef)param,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
}

- (void)configureView
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _chatData  = [[NSMutableArray alloc] init];
    self.responseData = [NSMutableData data];
    [self checkServerForNewMessages];
    [self configureView];
}

- (void)checkServerForNewMessages
{
    NSString *url = [NSString stringWithFormat:@"%@/getNewMemberMessages?owner=%@&sender=%@",
                        BASE_URL,
                        [[blinkMe me] memberIdAsString],
                        [_person memberIdAsString]];


    [blinkHttp asyncGetUrl:url withSelector:@selector(newMessages:) onObject:self];
    
    [self performSelector:@selector(checkServerForNewMessages) withObject:self afterDelay:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow:(NSNotification*) aNotification {
    NSLog(@"Keyboard was shown");
    NSDictionary* info = [aNotification userInfo];
    NSLog(@"%@", info);

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
       NSLog(@"chatView..%f..%f..%f..%f",_chatView.frame.origin.x, _chatView.frame.origin.y, _chatView.frame.size.width, _chatView.frame.size.height);
    NSLog(@"keyboard..%f..%f..%f..%f",keyboardFrame.origin.x, keyboardFrame.origin.y, keyboardFrame.size.width, keyboardFrame.size.height);
    [self.view setFrame:CGRectMake(
                                   self.view.frame.origin.x,
                                   self.view.frame.origin.y - keyboardFrame.size.height + 50,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height)];
    
//    [_chatView setFrame:CGRectMake(
//                                   self.view.frame.origin.x,
//                                   self.view.frame.origin.y + keyboardFrame.size.height * 2, //self.view.frame.origin.y + keyboardFrame.size.height - self.chat.frame.size.height - 30,
//                                   self.view.frame.size.width,
//                                   self.view.frame.size.height - keyboardFrame.size.height - 60)];
//    [_chatView scrollsToTop];

    
    NSLog(@"frame..%f..%f..%f..%f",self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"chatView..%f..%f..%f..%f",_chatView.frame.origin.x, _chatView.frame.origin.y, _chatView.frame.size.width, _chatView.frame.size.height);
    NSLog(@"keyboard..%f..%f..%f..%f",keyboardFrame.origin.x, keyboardFrame.origin.y, keyboardFrame.size.width, keyboardFrame.size.height);

    [UIView commitAnimations];
    
    CGPoint offset = CGPointMake(0, _chatView.contentSize.height - _chatView.frame.size.height);
    [_chatView setContentOffset:offset animated:YES];
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
                                   self.view.frame.origin.y + keyboardFrame.size.height - 50,
                                   self.view.frame.size.width, self.view.frame.size.height)];
//    [_chatView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 60)];
    [UIView commitAnimations];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
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
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];

    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d", [_chatData count]);
    return [_chatData count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"ChatCell";
	blinkChatCell *cell = (blinkChatCell*)[tableView dequeueReusableCellWithIdentifier: cellId];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"blinkChatCell" owner:self options:nil];
        cell = nib[0];
    }
    

    
//	NSUInteger row = [_chatData count]-[indexPath row]-1;    
    NSString *chatText = [_chatData[indexPath.row] objectForKey:@"text"];
    
       
//
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [chatText sizeWithFont:font constrainedToSize:CGSizeMake(225.0f, 1000.0f) lineBreakMode:NSLineBreakByWordWrapping];
//    cell.message.lineBreakMode = UILineBreakModeWordWrap;
    [cell.message setLineBreakMode:NSLineBreakByWordWrapping];
    cell.message.frame = CGRectMake(75, 14, size.width +20, size.height + 20);
    cell.message.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    cell.message.numberOfLines = 0;
    cell.message.text = chatText;
    cell.name.text = [_chatData[indexPath.row] objectForKey:@"name"];
    cell.message.adjustsFontSizeToFitWidth = NO;

    [cell.message sizeToFit];
    
     NSLog(@"ChatText: %@ %f %f %f %f", chatText, cell.message.frame.origin.x, cell.message.frame.origin.y, cell.message.frame.size.width, cell.message.frame.size.height);

    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [[_chatData objectAtIndex:_chatData.count-indexPath.row-1] objectForKey:@"text"];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    CGSize constraintSize = CGSizeMake(225.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize];
    
    return labelSize.height + 40;
}

#pragma HTTP Request

- (void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response
{
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:&myError];

    // show all values
    for(id key in res) {
        
        NSDictionary *value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
               
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"icon"];
        NSLog(@"icon: %@", icon);
    }
    
    NSLog(@"%@", myError);
    
}

-(void)newMessages:(NSData*)data
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    NSArray* messages = [json objectForKey:@"data"];
    
    NSLog(@"loans: %@", messages);
    
    
    if ([messages count]){
        NSLog(@"MESSAGE FOUND");
        NSDictionary* msg = [messages objectAtIndex:0];
        
        NSLog(@"%@", msg);
        NSDictionary* fromMember = @{@"id": [(NSDictionary*)[msg objectForKey:@"fromMember"]objectForKey:@"id"],
                                     @"name": [(NSDictionary*)[msg objectForKey:@"fromMember"]objectForKey:@"name"]};
        
        
        NSDictionary* toMember = @{@"id": [(NSDictionary*)[msg objectForKey:@"toMember"]objectForKey:@"id"],
                                   @"name": [(NSDictionary*)[msg objectForKey:@"toMember"]objectForKey:@"name"]};
        
        NSString *message = (NSString *)[msg objectForKey:@"message"];
        
        NSLog(@"\nFrom Member: %@  \n\nTo Member: %@ \n\nMessage: %@", fromMember, toMember, message);
        
        [self insertNewMessage:@{@"name": [fromMember objectForKey:@"name"],@"text":[msg objectForKey:@"message"]}];
        
        NSString *url = [NSString stringWithFormat:@"%@/markMessageRead?id=%@", BASE_URL, [msg objectForKey:@"id"]];
        [blinkHttp syncGetUrl:url withSelector:nil onObject:nil];
    }
   
//
//    [NSDictionary dictionaryWithObjectsAndKeys:
//         [loan objectForKey:@"name"],
//         @"who",
//     
//        [(NSDictionary*)[loan objectForKey:@"location"]objectForKey:@"country"],
//         @"where",
//     
//         [NSNumber numberWithFloat: outstandingAmount],
//         @"what",
//         nil];
////
////    if ([key isEqual: @"data"]){
////        NSString *message = [value objectForKey:@"message"];
////        NSLog(@"%@", message);
////    }

}

@end
