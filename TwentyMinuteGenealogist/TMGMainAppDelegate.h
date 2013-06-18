//
//  TMGMainAppDelegate.h
//  TwentyMinuteGenealogist
//
//  Created by Casey Moncur on 6/17/13.
//  Copyright (c) 2013 KinPoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMGMainAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
