//
//  TimerViewController.m
//  CountDownViewDemo
//
//  Created by wangtaiyi on 2018/7/5.
//  Copyright © 2018年 wangtaiyi. All rights reserved.
//

#import "TimerViewController.h"
#import "TestView.h"
#import "TYCountLabel.h"
#import "Masonry.h"
@interface TimerViewController ()
@property(nonatomic,strong)TYCountLabel *countDownLabel;
@property(nonatomic,strong)UIButton *btn;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //1.通过frame创建
//    TYCountDownLabel *countLabel = [[TYCountDownLabel alloc] initWithFrame:CGRectMake(100, 300, 0, 0)];
//    countLabel.totalSecond = 65;//设置剩余秒数
//    [self.view addSubview:countLabel];
//    [countLabel startTimer];
//    countLabel.timeEndBlock = ^{
//        NSLog(@"结束");
//    };
    
    //2.通过约束创建
    TYCountLabel *countLabel = [[TYCountLabel alloc] init];

    countLabel.font = [UIFont systemFontOfSize:30];
    countLabel.layer.cornerRadius = 8;
    countLabel.clipsToBounds = YES;
    self.countDownLabel = countLabel;
    [countLabel setupStartDate:[self getNowTimeTimestamp] AndEndDate:[self getNowTimeTimestamp]+6];//设置服务端给的开始和结束时间
    [self.view addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-30);
    }];
    
    
    
    //倒计时结束的回调
    countLabel.timeEndBlock = ^{
        NSLog(@"结束");
    };


    
    //暂停按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn = btn;
    [btn setTitle:@"暂停" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:253/255.0 green:68/255.0 blue:64/255.0 alpha:1];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(50);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

-(void)btnClick:(UIButton*)sender{
    sender.userInteractionEnabled = NO;
    if (sender.tag==0) {
        NSLog(@"暂停");
        [self.btn setTitle:@"恢复" forState:UIControlStateNormal];
        [self.countDownLabel pauseTimer];
        sender.tag = 1;
    }else{
        NSLog(@"恢复");
        [self.btn setTitle:@"暂停" forState:UIControlStateNormal];
        [self.countDownLabel startTimer];
        sender.tag = 0;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.userInteractionEnabled = YES;
    });
}

//销毁
-(void)dealloc{
    NSLog(@"TimerViewController~dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

@end
