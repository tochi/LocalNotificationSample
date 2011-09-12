//
//  LocalNotificationSampleAppDelegate.m
//  LocalNotificationSample
//
//  Created by tochi on 11/09/06.
//  Copyright 2011 aguuu Inc. All rights reserved.
//

#import "LocalNotificationSampleAppDelegate.h"

@implementation LocalNotificationSampleAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window.rootViewController = self.navigationController;
  [self.window makeKeyAndVisible];
  
  UILocalNotification *notification;
  notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
  if (notification) {
    [LocalNotificationManager addLocalNotification];
  }
  
  return YES;
}

- (void)application:(UIApplication *)application
    didReceiveLocalNotification:(UILocalNotification *)notification
{
  [LocalNotificationManager addLocalNotification];
  
  UIViewController *viewController = self.navigationController.topViewController;
  if ([viewController respondsToSelector:@selector(reloadData)]) {
    [(RootViewController *)viewController reloadData];
  }
}

- (void)dealloc
{
  [_window release];
  [_navigationController release];
  [super dealloc];
}

@end
