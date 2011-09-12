//
//  RootViewController.m
//  LocalNotificationSample
//
//  Created by tochi on 11/09/06.
//  Copyright 2011 aguuu Inc. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController (Private)
- (void)releaseOutlets;
@end

@implementation RootViewController
@synthesize tableView = tableView_;

#pragma mark -
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

- (void)dealloc
{
  [self releaseOutlets];
  
  [super dealloc];
}

- (void)releaseOutlets
{
  [tableView_ release], tableView_ = nil;
  [notifications_ release], notifications_ = nil;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIBarButtonItem *button;
  button = [[[UIBarButtonItem alloc] initWithTitle:@"Setting"
                                             style:UIBarButtonItemStylePlain
                                            target:self
                                            action:@selector(settingButtonClicked)] autorelease];
  self.navigationItem.rightBarButtonItem = button;
}

- (void)viewDidAppear:(BOOL)animated
{
  [self reloadData];
}

- (void)viewDidUnload
{
  [self releaseOutlets];

  [super viewDidUnload];
}

#pragma mark - UITableView, UITableViewDataSource delegate.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
  NSLog(@"---");
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [notifications_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:CellIdentifier] autorelease];
  }
  
  NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
  format.dateFormat = @"yyyy-MM-dd hh:mm:ss";
  
  UILocalNotification *notification = [notifications_ objectAtIndex:indexPath.row];
  cell.textLabel.text = [format stringFromDate:notification.fireDate];
  cell.detailTextLabel.text = notification.alertBody;
  NSLog(@"%@", [format stringFromDate:notification.fireDate]);
  
  return cell;
}

#pragma mark - Button clicked.
- (void)settingButtonClicked
{
  SettingViewController *viewController;
  viewController = [[[SettingViewController alloc] initWithNibName:@"SettingViewController"
                                                            bundle:nil] autorelease];
  UINavigationController *navigationController;
  navigationController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
  [self presentModalViewController:navigationController animated:YES];
}

- (void)reloadData
{
  [notifications_ autorelease];
  notifications_ = [[[UIApplication sharedApplication] scheduledLocalNotifications] retain];

  [tableView_ reloadData];
}

@end
