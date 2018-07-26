//
//  SPTLIVCountDownLabel.m
//  CountDownViewDemo
//
//  Created by wangtaiyi on 2018/7/24.
//  Copyright © 2018年 wangtaiyi. All rights reserved.
//

#import "TYCountDownLabel.h"

@interface TYCountDownLabel()
@property (nonatomic,assign)long hour;
@property (nonatomic,assign)long min;
@property (nonatomic,assign)long sec;

@property (nonatomic,assign)long startInterval;
@property (nonatomic,assign)long endInterval;
@property (nonatomic,strong)NSTimer *countDownTimer;
@end

@implementation TYCountDownLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInit];
        [self sizeToFit];
    }
    return self;
}

//初始化
-(void)setupInit{
    
    self.backgroundColor = [UIColor colorWithRed:253/255.0 green:68/255.0 blue:64/255.0 alpha:1];
    self.textColor = [UIColor whiteColor];
    self.hour = 0;
    self.min = 0;
    self.sec = 0;
    self.text = @"00:00:00";
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)timeFire{
    NSLog(@"currentThread~~~~:%@",[NSThread currentThread]);
    if (_sec==0) {
        if (_min==0) {
            if (_hour==0) {
                //倒计时结束
                [self removeTimer];
                self.text = @"倒计时结束";
                if (self.timeEndBlock) {
                    self.timeEndBlock();
                }
            }
            else{//有小时
                self.hour = _hour - 1;
                self.min = 59;
                self.sec = 59;
            }
        }else{//有分钟
            self.min = _min - 1;
            self.sec = 59;
        }
    }else{
        self.sec = _sec - 1;
    }
    
    CGSize size = [self calculateString:self.text];
    self.bounds  = CGRectMake(0, 0, size.width, size.height);
}

-(void)setTotalSecond:(long)totalSecond{
    _totalSecond = totalSecond;
    
    _hour = totalSecond / 3600;
    _min = totalSecond % 3600 /60;
    _sec = totalSecond % 60;
    
    NSString *hourStr = [NSString stringWithFormat:@"%.2ld:",_hour];
    NSString *minStr = [NSString stringWithFormat:@"%.2ld:",_min];
    NSString *secStr = [NSString stringWithFormat:@"%.2ld",_sec];
    
    NSString *timeStr = [[hourStr stringByAppendingString:minStr] stringByAppendingString:secStr];
    self.text = timeStr;

    CGSize size = [self calculateString:timeStr];
    self.bounds  = CGRectMake(0, 0, size.width, size.height);
}

-(void)setSec:(long)sec{
    _sec = sec;
    self.text = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",_hour,_min,_sec];
}

-(void)setMin:(long)min{
    _min = min;
    self.text = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",_hour,_min,_sec];
}

-(void)setHour:(long)hour{
    _hour = hour;
    self.text = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",_hour,_min,_sec];
}

-(void)startTimer{
    [self.countDownTimer setFireDate:[NSDate date]];
}

-(NSTimer *)countDownTimer{
    if (!_countDownTimer) {
        __weak typeof(self) weakSelf = self;
        _countDownTimer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(timeFire) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_countDownTimer forMode:NSRunLoopCommonModes];
    }
    return _countDownTimer;
}

-(void)pauseTimer{
    [_countDownTimer setFireDate:[NSDate distantFuture]];
}

-(void)dealloc{
    [_countDownTimer invalidate];
    _countDownTimer = nil;
    NSLog(@"CountDownView~dealloc");
}

-(void)removeTimer{
    NSLog(@"定时器已销毁");
    [_countDownTimer invalidate];
    _countDownTimer = nil;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (! newSuperview && self.countDownTimer) {
        // 销毁定时器
        [self removeTimer];
    }
}


//获取当前时间
-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //hh与HH:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *datenow = [NSDate date];
    
    //将NSDate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}

//获取当前时间戳
-(long)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    //hh:12小时制,HH:24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    long timeSp = (long)[datenow timeIntervalSince1970];
    
    return timeSp;
}

-(void)setupStartDate:(long)startInterval AndEndDate:(long)endInterval{
    
    //当前时间早于开始时间
    if (startInterval&&[self getNowTimeTimestamp]<startInterval) {
        NSLog(@"未开始");
        self.totalSecond = endInterval-startInterval;
        self.text = @"尚未开始";
        return;
    }
    
    //当前时间晚于开始时间，早于结束时间
    if (startInterval&&[self getNowTimeTimestamp]>=startInterval&&[self getNowTimeTimestamp]<endInterval) {
        NSLog(@"已经开始,未结束");
        self.totalSecond = endInterval - [self getNowTimeTimestamp];
        [self startTimer];
    }
    //当前时间晚于结束时间
    if (endInterval&&[self getNowTimeTimestamp]>=endInterval) {
        self.totalSecond = 0;
        self.text = @"倒计时结束";
    }
    
    
    CGSize size = [self calculateString:self.text];
    self.bounds  = CGRectMake(0, 0, size.width-4, size.height);
}

//通过文字计算NSString文字的大小
-(CGSize)calculateString:(NSString*)string{
    //高度固定不折行，根据字的多少计算label的宽度
    NSDictionary *fontDic = @{NSFontAttributeName : [UIFont systemFontOfSize:self.font.pointSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:fontDic context:nil].size;
    CGSize newSize = CGSizeMake(size.width+4, size.height);
    return newSize;
}

@end
