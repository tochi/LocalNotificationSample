//
//  SettingViewController.h
//  LocalNotificationSample
//
//  Created by tochi on 11/09/06.
//  Copyright 2011 aguuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekdayViewController.h"
#import "LocalNotificationManager.h"

@interface SettingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
@private
  UITableView *tableView_;
  UIDatePicker *datePicker_;
  NSMutableArray *tableData_;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@end
