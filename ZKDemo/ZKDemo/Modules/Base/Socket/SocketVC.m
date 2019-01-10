//
//  SocketVC.m
//  ZKDemo
//
//  Created by 李永华 on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//

#import "SocketVC.h"
#import "GCDAsyncSocket.h" // for TCP
#import "LocalPushCenter.h"

@interface SocketVC ()<GCDAsyncSocketDelegate,UNUserNotificationCenterDelegate>

@property(nonatomic,strong) GCDAsyncSocket *client;
@property(nonatomic,strong) NSTimer *timer;

@end

@implementation SocketVC

// MARK: - viewControlelr'view's lifeCircle
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_client disconnect];
    [_timer  invalidate];
    _timer = nil;
    NSLog(@"socket断开了连接！");
}

// MARK: - memory management
-(void)dealloc {
    [_client disconnect];
    _client.delegate = nil;
    _client = nil;
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"readData" style:UIBarButtonItemStylePlain target:self action:@selector(readData)];

    _client = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    [_client  connectToHost:@"192.168.0.199"
                     onPort:8080
                      error:&error];
    if (error) {
        NSLog(@"链接服务端失败!");
    } else{
        
    }
    if (@available(iOS 10.0, *)) {
        __weak typeof(self)weakSelf = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            __strong typeof(self) strongSelf = weakSelf;
            //向服务器发送数据
            [strongSelf sendDataToServer];
        }];
    } else {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(sendDataToServer) userInfo:nil repeats:YES];
    }
    [_timer fire];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    //监听接收服务端传过来的数据
    [_client readDataWithTimeout:-1 tag:123];
}


- (void)readData {
    [_client readDataToLength:1000 withTimeout:-1 tag:123];
}

-(void)sendDataToServer {
    [_client writeData:[@"HelloWord!" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:1.0 tag:123];
}
#pragma  MARK: -GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"连接上了服务端!");
}

// MARK: - 数据接收
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *recieveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.navigationItem.title = recieveStr;
    NSLog(@"接收到服务端的数据:%@",recieveStr);
    //监听服务端发送过来的数据
    [_client readDataWithTimeout:-1 tag:123];
    //本地推送一波
    [LocalPushCenter localPushForDate:[NSDate date]
                               forKey:recieveStr
                            alertBody:recieveStr
                          alertAction:recieveStr
                            soundName:nil
                          launchImage:nil
                             userInfo:@{@"info":recieveStr}
                           badgeCount:1
                       repeatInterval:NSCalendarUnitDay];
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag {

}

// MARK: - 数据发送
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"向服务端发送数据!");
}

// MARK: - 与服务端断开连接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"与服务端断开了!");
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
