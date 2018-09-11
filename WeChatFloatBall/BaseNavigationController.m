//
//  BaseNavigationController.m
//  WebViewDemo
//
//  Created by TIM on 2018/8/30.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import "BaseNavigationController.h"
#import "FloatBallManager.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return YES;
}

#pragma mark - UINavigationControllerDelegate
#pragma mark 实现自定义转场动画
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    return [[FloatBallManager shared] floatBallAnimationWithOperation:operation fromViewController:fromVC toViewController:toVC];
}

#pragma mark 交互式转场
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return [[FloatBallManager shared] floatInteractionControllerForAnimationController:animationController];
}

#pragma mark 添加滑动手势
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[FloatBallManager shared] didShowViewController:viewController navigationController:navigationController];
}

@end
