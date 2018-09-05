//
//  SecondViewController.m
//  WebViewDemo
//
//  Created by TIM on 2018/8/30.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"
#import "UIView+FloatFrame.h"

@interface SecondViewController ()
@property (nonatomic, strong) UIButton *pushButton;
@end

@implementation SecondViewController

- (void)dealloc
{
    NSLog(@"SecondViewController（测试页面） -- dealloc");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"测试页面";
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
    ViewController *vc = [ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter

- (UIButton *)pushButton
{
    if (!_pushButton) {
        _pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_pushButton setTitle:@"跳转正常页面" forState:UIControlStateNormal];
        [_pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushButton;
}

@end
