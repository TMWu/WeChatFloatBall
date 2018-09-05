//
//  ViewController.m
//  WebViewDemo
//
//  Created by TIM on 2018/8/29.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FloatFrame.h"
#import "SecondViewController.h"
#import "FloatBallDefine.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *pushButton;
@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"ViewController（正常页面） -- dealloc");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"正常页面";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pushButton];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.pushButton.size = CGSizeMake(100, 40);
    self.pushButton.center = self.view.center;
}

- (void)pushAction:(id)sender
{
    SecondViewController *vc = [SecondViewController new];
    vc.view.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255) / 255.0 alpha:1.0];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter

- (UIButton *)pushButton
{
    if (!_pushButton) {
        _pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_pushButton setTitle:@"跳转测试页面" forState:UIControlStateNormal];
        [_pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushButton;
}

@end
