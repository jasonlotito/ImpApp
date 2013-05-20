//
//  blinkMessagesController.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/17/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "blinkMessagesController.h"
#import "blinkHttp.h"
#import "blinkNewMessageCell.h"


@interface blinkMessagesController ()

@end

@implementation blinkMessagesController

@synthesize messages = _messages;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Messages";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Messages";
    _messages = [[NSMutableArray alloc]init];
    
    
    UITabBarItem *tbi = (UITabBarItem *) self.tabBarController.selectedViewController.tabBarItem;
    tbi.badgeValue = @"1";
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"messages-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self checkForMessages];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void)checkForMessages
{
    blinkMe *me = [blinkMe me];
    NSString *url = [NSString stringWithFormat:@"http://localhost:12345/getNewMemberMessages?owner=%@&sender=1", [NSString stringWithFormat:@"%d",me.memberId]];
    [blinkHttp asyncGetUrl:url withSelector:@selector(messagesChecked:) onObject:self];
    [self performSelector:@selector(checkForMessages) withObject:self afterDelay:2];
}

-(void)messagesChecked:(NSData*)data
{
    NSDictionary *json;
    parseJSON(json, data);
    NSLog(@"%@", json);
    NSArray *messageList = [json objectForKey:@"data"];

    
    if([messageList count]>0){
        NSLog(@"%@", messageList);
        NSDictionary *message = [messageList objectAtIndex:0];

        NSInteger messageId = [[message objectForKey:@"id"] integerValue];
        
        NSString *url = [NSString stringWithFormat:@"http://localhost:12345/markMessageRead?id=%@", [NSString stringWithFormat:@"%d",messageId]];
        [blinkHttp asyncGetUrl:url withSelector:@selector(logMarkMessageRead:) onObject:self];
        
        [_messages addObject:message];
        
        NSMutableArray *insertIndexPath = [[NSMutableArray alloc] init];
        
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] inSection:0];
        [insertIndexPath addObject:newPath];

        NSLog(@"JSON: %@ %d", message, [self.tableView numberOfRowsInSection:0]);
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logMarkMessageRead:(NSData*)data
{
    NSDictionary *res;
    parseJSON(res, data);
    NSLog(@"%@", res);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"blinkNewMessageCell";
    blinkNewMessageCell *cell = (blinkNewMessageCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"blinkNewMessageCell" owner:self options:nil];
        cell = nib[0];
    }
    NSLog(@"Loading cell");
    
    
    cell.senderName.text = [[[_messages objectAtIndex:indexPath.row]objectForKey:@"fromMember"]objectForKey:@"name"];
    cell.messageSent.text =[[_messages objectAtIndex:indexPath.row]objectForKey:@"sent"];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
