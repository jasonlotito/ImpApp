//
//  blinkProfileViewController.m
//  BlinkIt!
//
//  Created by Jason Lotito on 5/18/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import "blinkProfileViewController.h"
#import "blinkMe.h"

@interface blinkProfileViewController ()

@end

@implementation blinkProfileViewController

@synthesize me;
@synthesize profileName = _profileName;
@synthesize profileId = _profileId;

-(id)init
{
    self = [super init];
    
    if(self){
        setCellSelectedBackgroundColor(_nameCell, COLOR_YELLOW);
        setCellSelectedBackgroundColor(_emailCell, COLOR_YELLOW);
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    me = [blinkMe me];
    NSLog(@"viewDidLoad in profile");
    _profileName.text = me.name;
    _profileId.text = [me memberIdAsString];
    

    
    for(;false;) { \
        UIView *selectedBackgroundView = [[UIView alloc]initWithFrame:_nameCell.bounds]; \
        [selectedBackgroundView setBackgroundColor:COLOR_YELLOW]; \
        _nameCell.selectedBackgroundView = selectedBackgroundView; \
    }
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:COLOR_ORANGE_DARK] forBarMetrics:UIBarMetricsDefault];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
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
    NSLog(@"Did select to edit field");
}

@end
