//
//  LocalPushCenter.m
//  LocalPush
//
//  Created by zhuochenming on 3/11/16.
//  Copyright (c) 2016 zhuochenming. All rights reserved.
//

#import "LocalPushCenter.h"

@interface LocalPushCenter ()

@end

@implementation LocalPushCenter

+ (NSDate *)fireDateWithWeek:(NSInteger)week
                        hour:(NSInteger)hour
                      minute:(NSInteger)minute
                      second:(NSInteger)second {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone defaultTimeZone]];
    
    unsigned currentFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitSecond;
    
    NSDateComponents *component = [calendar components:currentFlag fromDate:[NSDate date]];
    
    if (week) {
        component.weekday = week;
    }
    if (hour) {
        component.hour = hour;
    }
    
    if (minute) {
        component.minute = minute;
    }
    if (second) {
        component.second = second;
    } else {
        component.second = 0;
    }
    
     return [[calendar dateFromComponents:component] dateByAddingTimeInterval:0];
}

#pragma mark - 本地推送
+ (void)localPushForDate:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
             alertAction:(NSString *)alertAction
               soundName:(NSString *)soundName
             launchImage:(NSString *)launchImage
                userInfo:(NSDictionary *)userInfo
              badgeCount:(NSUInteger)badgeCount
          repeatInterval:(NSCalendarUnit)repeatInterval {
    // 1.创建通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"徐不同测试通知";
    content.subtitle = @"测试通知";
    content.body = @"来自徐不同的简书";
    content.badge = @1;
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
    //设置通知附件内容
    UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"attachment error %@", error);
    }
    content.attachments = @[att];
    content.launchImageName = @"icon_certification_status1@2x";
    // 2.设置声音
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    // 3.触发模式
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.5 repeats:NO];
    // 4.设置UNNotificationRequest
    NSString *requestIdentifer = @"TestRequest";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger];
    //5.把通知加到UNUserNotificationCenter, 到指定触发点会被触发
    UNUserNotificationCenter *center  = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    if (!localNotification) {
//        return;
//    }
//
//    [self cancleLocalPushWithKey:key];
//
//    NSUInteger notificationType; //UIUserNotificationType(>= iOS8) and UIRemoteNotificatioNType(< iOS8) use same value
//    UIApplication *application = [UIApplication sharedApplication];
//    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
//        notificationType = [[application currentUserNotificationSettings] types];
//    } else {
//        notificationType = [application enabledRemoteNotificationTypes];
//    }
//    if (notificationType == UIRemoteNotificationTypeNone) {
//        return;
//    }
//
//    // ios8后，需要添加这个注册，才能得到授权
//    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//        // 通知重复提示的单位，可以是天、周、月
//        localNotification.alertBody        = alertBody;
//        localNotification.alertAction      = alertAction;
//        localNotification.alertLaunchImage = launchImage;
//        localNotification.repeatInterval   = repeatInterval;
//    } else {
//        localNotification.alertBody        = alertBody;
//        localNotification.alertAction      = alertAction;
//        localNotification.alertLaunchImage = launchImage;
//        localNotification.repeatInterval   = repeatInterval;
//    }
//
//    //Sound
//    if (soundName) {
//        localNotification.soundName = soundName;
//    } else {
//        localNotification.soundName = UILocalNotificationDefaultSoundName;
//    }
//
//    //Badge
//    if ((notificationType & UIRemoteNotificationTypeBadge) != UIRemoteNotificationTypeBadge) {
//    } else {
//        localNotification.applicationIconBadgeNumber = badgeCount;
//    }
//
//    if (!fireDate) {
//        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
//    } else {
//        localNotification.fireDate = fireDate;
//        localNotification.timeZone = [NSTimeZone defaultTimeZone];
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    }
//
}

#pragma mark - 退出
+ (void)cancelAllLocalPhsh {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+ (void)cancleLocalPushWithKey:(NSString *)key {
    NSArray *notiArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    if (notiArray) {
        for (UILocalNotification *notification in notiArray) {
            NSDictionary *dic = notification.userInfo;
            if (dic) {
                for (NSString *key in dic) {
                    if ([key isEqualToString:key]) {
                        [[UIApplication sharedApplication] cancelLocalNotification:notification];
                    }
                }
            }
        }
    }
}

#pragma mark - UNUserNotificationCenterDelegate
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    
}
//在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    //1. 处理通知
    
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert);
}

@end
