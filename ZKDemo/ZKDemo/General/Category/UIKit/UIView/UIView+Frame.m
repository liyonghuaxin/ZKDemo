//
//  UIView+YGFrame.m
//  YGOrderReceiving
//
//  Created by 曹向陶 on 2017/3/16.
//
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)yg_left {
    return self.frame.origin.x;
}

- (void)setYg_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)yg_top {
    return self.frame.origin.y;
}

- (void)setYg_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)yg_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYg_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)yg_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYg_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)yg_centerX {
    return self.center.x;
}

- (void)setYg_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)yg_centerY {
    return self.center.y;
}

- (void)setYg_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)yg_width {
    return self.frame.size.width;
}

- (void)setYg_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)yg_height {
    return self.frame.size.height;
}

- (void)setYg_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end

