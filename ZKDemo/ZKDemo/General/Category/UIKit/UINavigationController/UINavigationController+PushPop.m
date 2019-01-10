//
//  NSObject+PushPop.m
//  YiGuoApp3
//
//  Created by yiguomac on 2018/8/9.
//  Copyright © 2018年 yiguo. All rights reserved.
//

#import "UINavigationController+PushPop.h"

@implementation UINavigationController (PushPop)

- (void)yg_popThenPushViewController:(UIViewController *)pushvc animated:(BOOL)animated {
    __weak typeof(self)weakSelf = self;
    [self yg_pushViewController:pushvc animated:animated completion:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        NSMutableArray *tempArr = [strongSelf.childViewControllers mutableCopy];
        if (tempArr.count>2) {
            [tempArr removeObjectAtIndex:tempArr.count-2];
            [strongSelf setViewControllers:tempArr animated:NO];
        }
    }];
}

- (void)yg_popToViewController:(UIViewController *)popvc thenPushViewController:(UIViewController *)pushvc animated:(BOOL)animated {
    __weak typeof(self)weakSelf = self;
    [self yg_pushViewController:pushvc animated:animated completion:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        NSMutableArray *tempArr = [strongSelf.childViewControllers mutableCopy];
        if (tempArr.count>2) {
            NSInteger locate = [tempArr indexOfObject:popvc] + 1;
            NSInteger length = (tempArr.count - locate - 1);
            [tempArr removeObjectsInRange:NSMakeRange(locate, length)];
            [strongSelf setViewControllers:tempArr animated:NO];
        }
    }];
}

- (void)yg_popToViewControllerClass:(Class)popvcClass thenPushViewController:(UIViewController *)pushvc animated:(BOOL)animated {
    __weak typeof(self)weakSelf = self;
    [self yg_pushViewController:pushvc animated:animated completion:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        NSMutableArray *tempArr = [strongSelf.childViewControllers mutableCopy];
        if (tempArr.count>2) {
            for (UIViewController *subvc in self.childViewControllers.reverseObjectEnumerator.allObjects) {
                if ([subvc isKindOfClass:popvcClass]) {
                    NSInteger locate = [tempArr indexOfObject:subvc] + 1;
                    NSInteger length = (tempArr.count - locate - 1);
                    [tempArr removeObjectsInRange:NSMakeRange(locate, length)];
                    [strongSelf setViewControllers:tempArr animated:NO];
                    break;
                }
            }
        }
    }];
}

- (void)yg_popToRootThenPushViewController:(UIViewController *)pushvc animated:(BOOL)animated {
    __weak typeof(self)weakSelf = self;
    [self yg_pushViewController:pushvc animated:animated completion:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        NSMutableArray *tempArr = [strongSelf.childViewControllers mutableCopy];
        if (tempArr.count>2) {
            NSInteger locate = 1;
            NSInteger length = (tempArr.count - locate - 1);
            [tempArr removeObjectsInRange:NSMakeRange(locate, length)];
            [strongSelf setViewControllers:tempArr animated:NO];
        }
    }];
}

- (NSArray<__kindof UIViewController *> *)yg_popToViewControllerClass:(Class)viewControllerClass animated:(BOOL)animated {
    return [self yg_popToViewControllerClass:viewControllerClass animated:animated completion:nil];
}

- (NSArray<__kindof UIViewController *> *)yg_popToViewControllerClass:(Class)viewControllerClass animated:(BOOL)animated completion:(void (^)(void))completion {
    NSArray<__kindof UIViewController*> *viewControllers;
    for (UIViewController *subvc in self.childViewControllers.reverseObjectEnumerator.allObjects) {
        if ([subvc isKindOfClass:viewControllerClass]) {
            viewControllers = [self yg_popToViewController:subvc animated:animated completion:completion];
            break;
        }
    }
    return viewControllers;
}

//MARK:系统push|pop添加completion方法回调
- (void)yg_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    [CATransaction setCompletionBlock:completion];
    [CATransaction begin];
    [self pushViewController:viewController animated:animated];
    [CATransaction commit];
}

- (UIViewController *)yg_popViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    UIViewController *poppedViewController;
    [CATransaction setCompletionBlock:completion];
    [CATransaction begin];
    poppedViewController = [self popViewControllerAnimated:animated];
    [CATransaction commit];
    return poppedViewController;
}

- (NSArray<__kindof UIViewController *> *)yg_popToViewController:(UIViewController *)viewController animated:(BOOL)animated  completion:(void (^)(void))completion {
    NSArray<__kindof UIViewController*> *viewControllers;
    [CATransaction setCompletionBlock:completion];
    [CATransaction begin];
    viewControllers = [self popToViewController:viewController animated:animated];
    [CATransaction commit];
    return viewControllers;
}

- (NSArray<__kindof UIViewController *> *)yg_popToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    NSArray<__kindof UIViewController*> *viewControllers;
    [CATransaction setCompletionBlock:completion];
    [CATransaction begin];
    viewControllers = [self popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return viewControllers;
}

@end