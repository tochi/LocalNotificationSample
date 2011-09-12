//
//  SettingViewController.m
//  LocalNotificationSample
//
//  Created by tochi on 11/09/06.
//  Copyright 2011 aguuu Inc. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController (Private)
- (void)releaseOutlets;
@end

@implementation SettingViewController
@synthesize tableView = tableView_;
@synthesize datePicker = datePicker_;

#pragma mark -
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    tableData_ = [[NSMutableArray alloc] initWithCapacity:0];
    [tableData_ addObject:@"Repeat"];
  }
  return self;
}

- (void)dealloc
{
  [self releaseOutlets];
  
  [tableData_ release], tableData_ = nil;
  
  [super dealloc];
}

- (void)releaseOutlets
{
  [tableView_ release], tableView_ = nil;
  [datePicker_ release], datePicker_ = nil;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIBarButtonItem *button;
  button = [[[UIBarButtonItem alloc] initWithTitle:@"Close"
                                             style:UIBarButtonItemStylePlain
                                            target:self
                                            action:@selector(closeButtonClicked)] autorelease];
  self.navigationItem.rightBarButtonItem = button;
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  datePicker_.date = [userDefaults objectForKey:KEY_TIME];
  
  [tableView_ reloadData];
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
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [tableData_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:CellIdentifier] autorelease];
  }
  cell.textLabel.text = [tableData_ objectAtIndex:indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  WeekdayViewController *viewController;
  viewController = [[[WeekdayViewController alloc] initWithNibName:@"WeekdayViewController"
                                                            bundle:nil] autorelease];
  [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Button clicked.
- (void)closeButtonClicked
{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:datePicker_.date forKey:KEY_TIME];
  [userDefaults synchronize];
  
  [LocalNotificationManager addLocalNotification];
  
  [self dismissModalViewControllerAnimated:YES];
}
@end
