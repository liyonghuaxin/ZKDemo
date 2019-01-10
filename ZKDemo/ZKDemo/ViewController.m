//
//  ViewController.m
//  ZKDemo
//
//  Created by 李永华 on 2018/11/10.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ViewController.h"
#import "TestVC.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic,strong)NSThread *thread;


@end

@implementation ViewController
//- (NSMutableArray *)getMaxCount:(NSMutableArray *)array{
//    NSMutableArray *data = [array mutableCopy];
//    for (int i=0; i <[data count]-1; i++) {
//        for (int j=i; j <[data count]; j++) {
//            int first = [data[i] intValue];
//            int second = [data[j] intValue];
//            if (first < second) {
//                [data exchangeObjectAtIndex:i withObjectAtIndex:j];
//            }
//        }
//    }
//    NSMutableArray *dataArray = [NSMutableArray array];
//    [dataArray addObject:[NSNumber numberWithUnsignedInteger:[array indexOfObject:data[0]]]];
//    [dataArray addObject:[NSNumber numberWithUnsignedInteger:[array indexOfObject:data[1]]]];
//    return dataArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //----------------冒泡-------------------
//    [self getMaxCount:@[@"11",@"4",@"2",@"43",@"12",@"43"]];
    
    //----------------线程-------------------
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:btn];
//    btn.frame = CGRectMake(100, 200, 80, 30);
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
//    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
//    [self.thread start];
//    [self performSelector:@selector(action) onThread:self.thread withObject:nil waitUntilDone:NO ];

    
//    [self addSubview];
    
    
    //----------------加载本地html及资源-------------------
//    UIWebView *web = [[UIWebView alloc] init];
//    web.frame = self.view.frame;
//    [self.view addSubview:web];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSString *basePath = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
//    [web loadHTMLString:htmlString baseURL:baseURL];

}

-(void)addSubview{
    
    NSString *str = @"时时时";
    float btnWidth = 0;
    float btnHeight = 50;
    float labelWidth = 0;
    float edge = 8;//两边距离
    float space = 5;//图片和label距离
    float imageVWidth = 36;
    UIFont *font = [UIFont boldSystemFontOfSize:18];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    labelWidth = rect.size.width;
    btnWidth = labelWidth+space+imageVWidth+2*edge;
    if (btnWidth - 150 < 0) {
        btnWidth = 150;
    }
    
    // 搜索城市
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:leftBtn];
    leftBtn.layer.cornerRadius = btnHeight/2.0;
    leftBtn.layer.masksToBounds = YES;
    leftBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.height.equalTo(@((btnHeight)));
        make.top.equalTo(@(100));
        make.width.mas_equalTo(btnWidth);
    }];
    
    //城市名
    UILabel *cityNameLabel = [[UILabel alloc] init];
    cityNameLabel.font = font;
    cityNameLabel.tag = 100;
    cityNameLabel.textAlignment = NSTextAlignmentCenter;
    cityNameLabel.text = str;
    [leftBtn addSubview:cityNameLabel];
    [cityNameLabel setBackgroundColor:[UIColor orangeColor]];
    [cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(@(edge));
    }];
    
    //图片
    UIImageView *downImageView = [[UIImageView alloc] init];
    downImageView.backgroundColor = [UIColor redColor];
    downImageView.tag = 101;
    [leftBtn addSubview:downImageView];
    [downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-edge));
        make.left.equalTo(cityNameLabel.mas_right).offset(space);
        make.centerY.mas_equalTo(leftBtn);
        make.width.height.equalTo(@(imageVWidth));
    }];
}

#pragma mark runloop

-(void)click{
    TestVC *vc = [[TestVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)action{
    NSLog(@"dd");
    [NSThread sleepForTimeInterval:5];
    NSLog(@"tt");
}

- (void)run{
    //只要往RunLoop中添加了  timer、source或者observer就会继续执行，一个Run Loop通常必须包含一个输入源或者定时器来监听事件，如果一个都没有，Run Loop启动后立即退出。
    @autoreleasepool {
        
        //1、添加一个input source
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
        //2、添加一个定时器
        //    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
        //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        //    [[NSRunLoop currentRunLoop] run];
    }
}



@end
