//
//  WeekdayViewController.h
//  LocalNotificationSample
//
//  Created by tochi on 11/09/06.
//  Copyright 2011 aguuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekdayViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
@private
  UITableView *tableView_;
  NSMutableArray *tableData_;
  NSMutableArray *selectedData_;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@end
