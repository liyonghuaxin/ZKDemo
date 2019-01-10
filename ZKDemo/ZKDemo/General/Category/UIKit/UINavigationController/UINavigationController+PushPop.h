//
//  NSObject+PushPop.h
//  YiGuoApp3
//
//  Created by yiguomac on 2018/8/9.
//  Copyright © 2018年 yiguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (PushPop)

/**
 pop后再push(pushvc)(效果)
 (实际是先push(pushvc),完成后把当前vc移除)

 @param pushvc 需要push的viewcontroller
 @param animated 动画
 */
- (void)yg_popThenPushViewController:(UIViewController *)pushvc animated:(BOOL)animated;


/**
 pop到(popvc)后再push(pushvc)(效果)
 (实际是先push(pushvc),完成后把(popvc)和(pushvc)之间的移除)

 @param popvc popvc
 @param pushvc pushvc
 @param animated animation
 */
-(void)yg_popToViewController:(UIViewController *)popvc thenPushViewController:(UIViewController *)pushvc animated:(BOOL)animated;


/**
 pop到(最后一个popvcClass)后再push(pushvc)(效果)
 (实际是先push(pushvc),完成后把(最后一个popvcClass)和(pushvc)之间的移除)

 @param popvcClass popvcClass
 @param pushvc pushvc
 @param animated animated
 */
-(void)yg_popToViewControllerClass:(Class)popvcClass thenPushViewController:(UIViewController *)pushvc animated:(BOOL)animated;


/**
 pop到rootvc后再push(pushvc)(效果)
 (实际是先push(pushvc),完成后把(rootvc)和(pushvc)之间的移除)

 @param pushvc pushvc
 @param animated animated
 */
- (void)yg_popToRootThenPushViewController:(UIViewController *)pushvc animated:(BOOL)animated;


/**
 popToViewController:animated-->popToViewControllerClass:animated
 如果有多个viewControllerClass在栈中,pop到最后的那个(如果要指定到具体的某一个,则使用系统方法 popToViewController:animated)

 @param viewControllerClass viewControllerClass
 @param animated animated
 @return Returns the popped controllers
 */
- (NSArray<__kindof UIViewController *> *)yg_popToViewControllerClass:(Class)viewControllerClass animated:(BOOL)animated;


/**
 popToViewController:animated-->popToViewControllerClass:animated+完成
 如果有多个viewControllerClass在栈中,pop到最后的那个(如果要指定到具体的某一个,则使用系统方法 popToViewController:animated)

 @param viewControllerClass viewControllerClass
 @param animated animated
 @param completion completion
 @return Returns the popped controllers
 */
- (NSArray<__kindof UIViewController *> *)yg_popToViewControllerClass:(Class)viewControllerClass animated:(BOOL)animated completion: (void (^)(void))completion;


/**
 pushViewController:animated:+完成

 @param viewController viewController
 @param animated animated
 @param completion completion
 */
- (void)yg_pushViewController:(UIViewController*)viewController animated:(BOOL)animated completion: (void (^)(void))completion;


/**
 popViewControllerAnimated:+完成

 @param animated animated
 @param completion completion
 @return Returns the popped controller
 */
- (UIViewController *)yg_popViewControllerAnimated:(BOOL)animated completion: (void (^)(void))completion;


/**
 popToViewController:animated+完成

 @param viewController viewController
 @param animated animated
 @param completion completion
 @return Returns the popped controllers
 */
- (NSArray<__kindof UIViewController *> *)yg_popToViewController:(UIViewController *)viewController animated:(BOOL)animated  completion: (void (^)(void))completion;


/**
 popToRootViewControllerAnimated:+完成

 @param animated animated
 @param completion completion
 @return Returns the popped controllers
 */
- (NSArray<__kindof UIViewController *> *)yg_popToRootViewControllerAnimated:(BOOL)animated completion: (void (^)(void))completion;

@end
