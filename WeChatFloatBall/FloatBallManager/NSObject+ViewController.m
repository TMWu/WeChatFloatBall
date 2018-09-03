//
//  NSObject+ViewController.m
//  WebViewDemo
//
//  Created by TIM on 2018/8/31.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import "NSObject+ViewController.h"

@implementation NSObject (ViewController)

+ (UIViewController *)currentViewController
{
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)nextResponder;
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController *) vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController *) vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }
        while (vc.childViewControllers.count) {
            vc = [vc.childViewControllers lastObject];
        }
        result = vc;
    }
    else {
        result = window.rootViewController;
    }
    return result;
}

+ (UINavigationController *)currentNavigationController
{
    return [self currentViewController].navigationController;
}

+ (UITabBarController *)currentTabBarController
{
    return [self currentViewController].tabBarController;
}

@end
