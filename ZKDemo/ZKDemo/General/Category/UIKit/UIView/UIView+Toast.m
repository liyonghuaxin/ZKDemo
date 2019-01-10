//
//  UIView+Toast.m
//  BaiJiaManage
//
//  Created by yiguomac on 2017/10/27.
//  Copyright © 2017年 BaiJiaBest. All rights reserved.
//

#import "UIView+Toast.h"

@implementation UIView (Toast)

- (void)showToastWithTitle:(NSString *)title duration:(NSTimeInterval)duration complection:(void(^)(void))complection {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [hud hideAnimated:YES];
        if (complection) {
            complection();
        }
    });
}

- (void)showToastWithError:(NSError *)error duration:(NSTimeInterval)duration complection:(void(^)(void))complection {
    NSString * title = nil;
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        if (error.code == NSURLErrorCancelled) {  // 网络请求取消
            return;
        }
        
        switch (error.code) {
            case NSURLErrorNotConnectedToInternet:
                title = @"网络连接失败";
                break;
            case NSURLErrorUnknown:
                title = @"未知错误";
                break;
            case NSURLErrorTimedOut:
                title = @"网络超时";
                break;
            default:
                title = @"连接服务器失败";
                break;
        }
    } else {
        if (error.localizedDescription.length == 0) {
            title = @"服务器未知错误";
        }
        else {
            title = error.localizedDescription;
        }
    }
    [self showToastWithTitle:title duration:duration complection:complection];
}

- (MBProgressHUD *)showLoadingHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    
    return hud;
}

- (MBProgressHUD *)showLoadingHUDWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.label.text = title;
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    
    return hud;
}

- (void)hideAllHUD {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self animated:YES];
        });
    });
}

@end
