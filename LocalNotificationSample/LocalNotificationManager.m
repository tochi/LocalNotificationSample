//
//  LocalNotificationManager.m
//  LocalNotificationSample
//
//  Created by tochi on 11/09/06.
//  Copyright 2011 aguuu Inc. All rights reserved.
//

#import "LocalNotificationManager.h"

@implementation LocalNotificationManager

+ (void)addLocalNotification
{
  [[UIApplication sharedApplication] cancelAllLocalNotifications];
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSArray *selectedWeek = [userDefaults arrayForKey:KEY_WEEK];
  NSDate *notificationTime = [userDefaults objectForKey:KEY_TIME];
  
  NSInteger repeartCount = 7;
  NSDate *today = [NSDate date];
  NSDate *date;
  NSString *dateString;
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *dateComponents;
  
  NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
  format.dateFormat = @"yyyy-MM-dd hh:mm";
  
  NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
  dateFormat.dateFormat = @"yyyy-MM-dd";
  
  NSDateFormatter *timeFormat = [[[NSDateFormatter alloc] init] autorelease];
  timeFormat.dateFormat = @"hh:mm";
  
  UILocalNotification *notification = [[[UILocalNotification alloc] init] autorelease];
  
  for (NSInteger i = 0; i < repeartCount; i++) {
    date = [today dateByAddingTimeInterval:i * 24 * 60 * 60];
    dateComponents = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    
    if ([selectedWeek containsObject:[NSNumber numberWithInteger:dateComponents.weekday - 1]]) {
      // Adding the local notification.
      dateString = [NSString stringWithFormat:@"%@ %@",
                    [dateFormat stringFromDate:date],
                    [timeFormat stringFromDate:notificationTime]];
      
      if ([today compare:[format dateFromString:dateString]] == NSOrderedAscending) {
        notification.fireDate = [format dateFromString:dateString];
        notification.timeZone = [NSTimeZone localTimeZone];
        notification.alertBody = [NSString stringWithFormat:@"Notify:%@", dateString];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertAction = @"Open";
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
      }
    }
  }
}

@end
