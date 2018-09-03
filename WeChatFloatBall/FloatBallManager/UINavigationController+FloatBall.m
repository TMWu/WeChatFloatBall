//
//  UINavigationController+FloatBall.m
//  WebViewDemo
//
//  Created by TIM on 2018/9/3.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import "UINavigationController+FloatBall.h"
#import "FloatBallManager.h"
#import <objc/runtime.h>

@implementation UINavigationController (FloatBall)

//+ (void)load
//{
//    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(popViewControllerAnimated:)), class_getInstanceMethod([self class], @selector(float_popViewControllerAnimated:)));
//    
//    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(pushViewController:animated:)), class_getInstanceMethod([self class], @selector(float_pushViewController:animated:)));
//}
//
//- (UIViewController *)float_popViewControllerAnimated:(BOOL)animated
//{
//    UIViewController *vc = [self float_popViewControllerAnimated:animated];
//    //pop操作有可能取消，在内部重新禁用系统手势
//    if (vc && [[FloatBallManager shared].classes containsObject:NSStringFromClass([vc class])]) {
//        self.interactivePopGestureRecognizer.enabled = YES;
//    }
//    return vc;
//}
//
//- (void)float_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    //push到要监控的控制器时，将系统右滑手势禁用
//    if ([[FloatBallManager shared].classes containsObject:NSStringFromClass([viewController class])]) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//        // 边缘手势
//        UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:[FloatBallManager shared] action:@selector(handleNavigationTransition:)];
//        gesture.edges = UIRectEdgeLeft;
//        gesture.delegate = [FloatBallManager shared];
//        [viewController.view addGestureRecognizer:gesture];
//    }
//    else {
//        self.interactivePopGestureRecognizer.enabled = YES;
//    }
//    [self float_pushViewController:viewController animated:animated];
//}

@end
