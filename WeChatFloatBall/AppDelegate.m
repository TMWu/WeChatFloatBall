//
//  AppDelegate.m
//  WebViewDemo
//
//  Created by TIM on 2018/8/29.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FloatBallManager.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ViewController *vc = [ViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    //添加要监控的类名
    [[FloatBallManager shared] addFloatMonitorVCClasses:@[@"SecondViewController"]];
    return YES;
}

@end
