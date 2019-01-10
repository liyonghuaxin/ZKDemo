//
//  UIView+NoData.m
//  Angelet
//
//  Created by 李永华 on 2019/1/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIView+NoData.h"
#import <objc/runtime.h>

static const char noDataKey;

@implementation UIView (NoData)

- (void)removeNoDataView{
    UIView *view = [self viewWithTag:10241];
    if (view) {
        UIScrollView *scrollV = [self viewWithTag:10240];
        if (scrollV.mj_header.refreshing) {
            [scrollV.mj_header endRefreshingWithCompletionBlock:^{
                UIView *view = [self viewWithTag:10241];
                [view removeFromSuperview];
            }];
        }else{
            [SVProgressHUD dismiss];
            UIView *view = [self viewWithTag:10241];
            [view removeFromSuperview];
        }
    }
}

- (void)addNoDataView:(void (^)(void))block{
    UIView *bgView = [[UIView alloc] init];
    bgView.tag  = 10241;
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    scrollV.tag  = 10240;
    [bgView addSubview:scrollV];
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    scrollV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    
    UILabel *desLab = [[UILabel alloc] init];
    [bgView addSubview:desLab];
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_offset(CGSizeMake(100, 50));
    }];
    desLab.font = [UIFont systemFontOfSize:14+fontSizeAdjust];
    desLab.textColor = [UIColor redColor];
    desLab.text = @"没数据";
    
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoDataView)]];
    objc_setAssociatedObject(self, &noDataKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (void)clickNoDataView{
    [SVProgressHUD showWithStatus:nil];
    void(^block)(void) = objc_getAssociatedObject(self, &noDataKey);
    if (block) {
        block();
    }
}

@end
