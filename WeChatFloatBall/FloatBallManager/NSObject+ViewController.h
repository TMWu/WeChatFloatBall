//
//  NSObject+ViewController.h
//  WebViewDemo
//
//  Created by TIM on 2018/8/31.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (ViewController)

+ (UIViewController *)currentViewController;

+ (UINavigationController *)currentNavigationController;

+ (UITabBarController *)currentTabBarController;

@end
