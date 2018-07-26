# TYCountDownLabel

#### 项目介绍
一款简单的倒计时控件

#### 软件架构
继承自UILabel


#### 安装教程

1. 直接拖入TYCountLabel文件夹到工程，
#import "TYCountLabel.h"即可

2. 支持cocoapods导入

pod 'TYCountLabel', '~> 0.0.1'

#### 使用说明

###创建

1. 通过frame创建

TYCountLabel *countLabel = [[TYCountLabel alloc] initWithFrame:CGRectMake(100, 300, 0, 0)];
[self.view addSubview:countLabel];


2. 通过约束创建

TYCountLabel *countLabel = [[TYCountLabel alloc] init];

[self.view addSubview:countLabel];

[countLabel mas_makeConstraints:^(MASConstraintMaker *make) {

make.centerX.equalTo(self.view.mas_centerX);

make.centerY.equalTo(self.view.mas_centerY).offset(-30);

}];


###设置倒计时时间

1.通过设置剩余秒数

countLabel.totalSecond = 65;//设置剩余秒数


2.通过服务端给的开始和结束时间，两个时间戳创建

[countLabel setupStartDate:XXXX AndEndDate:XXXX];

#### 参与贡献

1. Fork 本项目
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request



