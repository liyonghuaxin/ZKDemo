//
//  UIView+NoData.h
//  Angelet
//
//  Created by 李永华 on 2019/1/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NoData)

- (void)addNoDataView:(void(^)(void))block;

- (void)removeNoDataView;

@end

NS_ASSUME_NONNULL_END
