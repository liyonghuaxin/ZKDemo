//
//  YCMenuVC.m
//  ZKDemo
//
//  Created by 李永华 on 2018/11/10.
//  Copyright © 2018 mac. All rights reserved.
//

#import "YCMenuVC.h"
#import "YCMenuView.h"

@interface YCMenuVC ()

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation YCMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArr = [NSMutableArray array];

    UIImage *image = [UIImage imageNamed:@"apple"];
    NSArray *array = @[@"首页",@"个人",@"最新",@"搜索",@"新闻",@"我的"];
    for (NSString *str in array) {
        YCMenuAction *action = [YCMenuAction actionWithTitle:str image:image handler:^(YCMenuAction *action) {
            NSLog(@"点击了%@",action.title);
        }];
        [_dataArr addObject:action];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 80, 40);
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = randomColor;
    btn.layer.borderColor = randomColor.CGColor;
    btn.layer.borderWidth = 1;
    [self.view addSubview:btn];
    
}

- (void)click:(id)sender{
    YCMenuView *view = [YCMenuView menuWithActions:self.dataArr width:140 relyonView:sender];
    [view show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint P = [touch locationInView:self.view];
    // 创建
    YCMenuView *view = [YCMenuView menuWithActions:self.dataArr width:140 atPoint:P];
    // 自定义设置
    //    view.menuColor = [UIColor whiteColor];
    //    view.separatorColor = [UIColor whiteColor];
    //    view.maxDisplayCount = 5;
    //    view.offset = 0;
    //    view.textColor = [UIColor whiteColor];
    //    view.textFont = [UIFont boldSystemFontOfSize:18];
    //    view.menuCellHeight = 60;
    //    view.dismissOnselected = YES;
    //    view.dismissOnTouchOutside = YES;
    
    // 显示
    [view show];
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
