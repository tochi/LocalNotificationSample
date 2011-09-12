//
//  WeekdayViewController.m
//  LocalNotificationSample
//
//  Created by tochi on 11/09/06.
//  Copyright 2011 aguuu Inc. All rights reserved.
//

#import "WeekdayViewController.h"

@interface WeekdayViewController (Private)
- (void)releaseOutlets;
@end

@implementation WeekdayViewController
@synthesize tableView = tableView_;

#pragma mark -
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    tableData_ = [[NSMutableArray alloc] initWithCapacity:0];
    [tableData_ addObject:@"Evert Sunday"];
    [tableData_ addObject:@"Evert Monday"];
    [tableData_ addObject:@"Evert Tuesday"];
    [tableData_ addObject:@"Evert Wednesday"];
    [tableData_ addObject:@"Evert Thursday"];
    [tableData_ addObject:@"Evert Friday"];
    [tableData_ addObject:@"Evert Saturday"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    selectedData_ = [[NSMutableArray alloc] initWithArray:[userDefaults arrayForKey:KEY_WEEK]];
  }
  return self;
}

- (void)dealloc
{
  [self releaseOutlets];
  
  [tableData_ release], tableData_ = nil;
  [selectedData_ release], selectedData_ = nil;
  
  [super dealloc];
}

- (void)releaseOutlets
{
  [tableView_ release], tableView_ = nil;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
  [super viewDidLoad];
    
  [tableView_ reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:selectedData_ forKey:KEY_WEEK];
  [userDefaults synchronize];
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
  
  if ([selectedData_ containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  }
  
  cell.textLabel.text = [tableData_ objectAtIndex:indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *selectedCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
  if (selectedCell.accessoryType == UITableViewCellAccessoryNone) {
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [selectedData_ addObject:[NSNumber numberWithInteger:indexPath.row]];
  } else {
    selectedCell.accessoryType = UITableViewCellAccessoryNone;
    
    [selectedData_ removeObject:[NSNumber numberWithInteger:indexPath.row]];
  }
  
  [tableView_ deselectRowAtIndexPath:indexPath animated:YES];
}
@end
