//
//  AppDelegate.m
//  ZKDemo
//
//  Created by 李永华 on 2018/11/10.
//  Copyright © 2018 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Test.h"
#import "CYLTabBarController.h"
#import "ZBNavigationController.h"
#import "UIVC.h"
#import "FunctionVC.h"
#import "BaseVC.h"

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [self testSomething];
    
//    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        // 用户对通知的设置
//        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//            NSLog(@"%@", (long)settings.authorizationStatus == 2 ? @"成获取到通知权限" : @"用户关闭了通知");
//            if (settings.authorizationStatus != 2) {
//                NSLog(@"用户关闭了通知");
//            }
//        }];
//    }];
    
    //本地通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    //iOS 10 使用以下方法注册，才能得到授权，注册通知以后，会自动注册 deviceToken，如果获取不到 deviceToken，
    //Xcode8下要注意开启 Capability->Push Notification。
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                          }];
    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"%@", (long)settings.authorizationStatus == 2 ? @"成获取到通知权限" : @"用户关闭了通知");
        if (settings.authorizationStatus != 2) {
            NSLog(@"用户关闭了通知");
        }
    }];
    
    //初始化tabbar
    UIVC *vc1 = [[UIVC alloc] init];
    ZBNavigationController *nav1 = [[ZBNavigationController alloc] initWithRootViewController:vc1];
    
    FunctionVC *vc2 = [[FunctionVC alloc] init];
    ZBNavigationController *nav2 = [[ZBNavigationController alloc] initWithRootViewController:vc2];
    
    BaseVC *vc3 = [[BaseVC alloc] init];
    ZBNavigationController *nav3 = [[ZBNavigationController alloc] initWithRootViewController:vc3];
    
    NSDictionary *attrDict1 = @{
                                CYLTabBarItemTitle : @"控件",
                                CYLTabBarItemImage : @"nav_classify",
                                CYLTabBarItemSelectedImage : @"nav_classify_selected",
                                CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0, -2)]
                                };
    NSDictionary *attrDict2 = @{
                                CYLTabBarItemTitle : @"功能",
                                CYLTabBarItemImage : @"nav_find",
                                CYLTabBarItemSelectedImage : @"nav_find_selected",
                                CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0, -2)]
                                };
    NSDictionary *attrDict3 = @{
                                CYLTabBarItemTitle : @"基础",
                                CYLTabBarItemImage : @"nav_classify",
                                CYLTabBarItemSelectedImage : @"nav_classify_selected",
                                CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0, -2)]
                                };
    
    CYLTabBarController *tabbar = [[CYLTabBarController alloc] initWithViewControllers:@[nav1,nav2,nav3] tabBarItemsAttributes:@[attrDict1,attrDict2,attrDict3]];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = tabbar;
    
//    ViewController *vc = [[ViewController alloc] init];
//    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
//    self.window.rootViewController = navigationVC;
    
    return YES;
}


#pragma mark - UNUserNotificationCenterDelegate
//在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    //1. 处理通知
    
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
