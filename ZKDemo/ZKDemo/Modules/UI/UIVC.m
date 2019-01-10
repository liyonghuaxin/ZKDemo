//
//  UIVC.m
//  ZKDemo
//
//  Created by 李永华 on 2018/11/10.
//  Copyright © 2018 mac. All rights reserved.
//

#import "UIVC.h"
#import "YCMenuVC.h"

@interface UIVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataArr;
}

@end

@implementation UIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr = @[@"MenuView"];
    
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
        YCMenuVC *vc = [[YCMenuVC alloc] init];
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
