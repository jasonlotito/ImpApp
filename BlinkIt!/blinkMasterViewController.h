//
//  blinkMasterViewController.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/15/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <UIKit/UIKit.h>

@class blinkDetailViewController;

#import <CoreData/CoreData.h>

@interface blinkMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSDictionary *friendChatList;
@property (nonatomic) CFIndex friendCount;
@property (nonatomic) CFArrayRef friendsList;
@property (strong, nonatomic) NSArray *friends;
@property (strong, nonatomic) blinkDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
