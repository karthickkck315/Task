//
//  AppDelegate.h
//  MasonaryExample
//
//  Created by karthick on 12/05/19.
//  Copyright © 2019 karthick. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

