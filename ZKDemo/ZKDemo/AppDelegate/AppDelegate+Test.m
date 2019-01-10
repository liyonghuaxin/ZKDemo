//
//  AppDelegate+Test.m
//  ZKDemo
//
//  Created by 李永华 on 2018/11/20.
//  Copyright © 2018 mac. All rights reserved.
//

#import "AppDelegate+Test.h"

@implementation AppDelegate (Test)

- (void)testSomething{
    NSMutableArray *arr1 = [[NSMutableArray alloc]initWithObjects:@"SHI",@"XIAO",@"ABC",@"ABC",@"SHI",@"HU",nil];
    //    for(NSString *str in arr1){
    //        NSLog(@"%@",str);
    //        if([str isEqualToString:@"SHI"]){
    //            [arr1 removeObject:str];
    //            break;//一次删多个，有break不崩
    //        }
    //    }
    
    //    for (int i = 0; i < arr1.count; i++) {
    //        NSString *str = arr1[i];
    //        if([str isEqualToString:@"SHI"]){
    //            [arr1 removeObject:str];
    //            i--;
    //        }
    //    }
    
    //    [arr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        if ([obj isEqualToString:@"SHI"]) {
    //            [arr1 removeObject:obj];//一次删多个
    //            *stop = YES;
    //        }
    //    }];
}

@end
