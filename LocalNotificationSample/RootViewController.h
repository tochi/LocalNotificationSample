//
//  RootViewController.h
//  LocalNotificationSample
//
//  Created by tochi on 11/09/06.
//  Copyright 2011 aguuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

@interface RootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
 @private
  UITableView *tableView_;
  NSArray *notifications_;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void)reloadData;
@end
