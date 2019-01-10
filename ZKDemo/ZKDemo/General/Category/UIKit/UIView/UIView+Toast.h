//
//  UIView+Toast.h
//  BaiJiaManage
//
//  Created by yiguomac on 2017/10/27.
//  Copyright © 2017年 BaiJiaBest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (Toast)

/**
 显示一个toast，没有阻碍交互
 */
- (void)showToastWithTitle:(NSString *)title duration:(NSTimeInterval)duration complection:(void(^)(void))complection;


/**
 显示一个error
 */
- (void)showToastWithError:(NSError *)error duration:(NSTimeInterval)duration complection:(void(^)(void))complection;


/**
 显示MBProgressHUD加载框
 */
- (MBProgressHUD *)showLoadingHUD;


/**
 显示一个带有文字提示的MBProgressHUD加载框
 */
- (MBProgressHUD *)showLoadingHUDWithTitle:(NSString *)title;

/**
 隐藏所有MBProgressHUD加载框
 */
- (void)hideAllHUD;

@end
