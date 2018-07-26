//
//  SPTLIVCountDownLabel.h
//  CountDownViewDemo
//
//  Created by wangtaiyi on 2018/7/24.
//  Copyright © 2018年 wangtaiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYCountDownLabel : UILabel
@property (nonatomic,assign)long totalSecond;  //总秒数
@property (nonatomic,copy)void (^timeEndBlock)(void);  //倒计时结束的block
-(void)startTimer;      //开始
-(void)pauseTimer;      //暂停
//vc的dealloc请调用防止循环引用
-(void)removeTimer;
-(void)setupStartDate:(long)startInterval AndEndDate:(long)endInterval;
@end
