//
//  blinkAppDelegate.h
//  BlinkIt!
//
//  Created by Jason Lotito on 5/15/13.
//  Copyright (c) 2013 Jason Lotito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blinkAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
