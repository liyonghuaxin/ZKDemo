//
//  CALayerVC.m
//  ZKDemo
//
//  Created by 李永华 on 2018/11/19.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CALayerVC.h"
#import "LayerView.h"

@interface CALayerVC ()

@end

@implementation CALayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    LayerView *view = [[LayerView alloc] init];
    [self.view addSubview:view];
    view.frame = CGRectMake(100, k_Height_NavBar+100, 100, 100);
    view.backgroundColor = [UIColor lightGrayColor];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.frame = CGRectMake(0, 0, 50, 50);
    layer.position = CGPointMake(0, 0);
    layer.anchorPoint = CGPointMake(1, 11);
    [view.layer addSublayer:layer];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
