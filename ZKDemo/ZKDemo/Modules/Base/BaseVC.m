//
//  BaseVC.m
//  ZKDemo
//
//  Created by 李永华 on 2018/11/19.
//  Copyright © 2018 mac. All rights reserved.
//

#import "BaseVC.h"
#import "CALayerVC.h"
#import "SocketVC.h"

@interface BaseVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataArr;
}

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
 
    dataArr = @[@"CALayer",@"Socket"];
    
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:tab];
    tab.delegate = self;
    tab.dataSource = self;
    tab.tableFooterView = [[UIView alloc] init];
    [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CALayerVC *vc = [[CALayerVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        SocketVC *vc = [[SocketVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = dataArr[indexPath.row];
    return cell;
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
