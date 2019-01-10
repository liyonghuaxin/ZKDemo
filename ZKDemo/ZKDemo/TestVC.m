//
//  TestVC.m
//  ZKDemo
//
//  Created by 李永华 on 2018/11/21.
//  Copyright © 2018 mac. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 200, 80, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    //内存泄漏
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2
                                                  target:self
                                                selector:@selector(p_doSomeThing)
                                                userInfo:nil
                                                 repeats:YES];
}

-(void)click{
    NSLog(@"pppppppppp");
    [self p_stopDoSomeThing];
}

- (void)p_doSomeThing {
    // doSomeThing
    NSLog(@"doSomeThing");
}

- (void)p_stopDoSomeThing {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    [self.timer invalidate];
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
