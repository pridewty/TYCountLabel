//
//  ViewController.m
//  CountDownViewDemo
//
//  Created by wangtaiyi on 2018/7/5.
//  Copyright © 2018年 wangtaiyi. All rights reserved.
//

#import "ViewController.h"
#import "TimerViewController.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:253/255.0 green:68/255.0 blue:64/255.0 alpha:1];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld",[self getNowTimeTimestamp]];
    NSLog(@"当前timeSp:%@",timeSp);

}


- (void)btnClick:(UIButton *)sender{
    TimerViewController *tVc = [[TimerViewController alloc] init];

    [self.navigationController pushViewController:tVc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取当前时间戳
-(long)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //格式,hh与HH:表示12小时制,24小时制
    
    //设置时区,很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    
    NSInteger timeSp = (long)[datenow timeIntervalSince1970];
    
    return timeSp;
}

//获取当前时间
-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //hh与HH:12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *datenow = [NSDate date];
    
    //将NSDate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

@end
