//
//  FloatTransitionAnimator.m
//  WebViewDemo
//
//  Created by TIM on 2018/8/30.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import "FloatTransitionAnimator.h"
#import "FloatBallDefine.h"
#import "UIView+FloatFrame.h"
#import "NSObject+ViewController.h"
#import <objc/runtime.h>
#import "FloatBallManager.h"

@interface FloatTransitionAnimator ()<CAAnimationDelegate>

/** 悬浮球圆心坐标 */
@property (nonatomic, assign) CGPoint center;
/** 悬浮球半径 */
@property (nonatomic, assign) CGFloat radius;
/** 遮罩 */
@property(nonatomic, strong) UIView *coverView;

@end

@implementation FloatTransitionAnimator

+ (instancetype)animatorWithStartCenter:(CGPoint)center
                                 radius:(CGFloat)radius
                              operation:(UINavigationControllerOperation)operation
{
    return [[self alloc] initWithStartCenter:center radius:radius operation:operation];
}

- (instancetype)initWithStartCenter:(CGPoint)center
                             radius:(CGFloat)radius
                          operation:(UINavigationControllerOperation)operation
{
    self = [super init];
    if (self) {
        _center = center;
        _radius = radius;
        _operation = operation;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return AnimationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    if (_operation == UINavigationControllerOperationPush) {
        //push转场动画执行前，隐藏悬浮球
        [[NSNotificationCenter defaultCenter] postNotificationName:AnimationWillBeginKey object:nil];
        [self animatePushAnimation:transitionContext];
    }
    else if (_operation == UINavigationControllerOperationPop) {
        [self animatePopAnimation:transitionContext];
    }
}

#pragma mark Push转场动画
- (void)animatePushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:self.coverView];
    [containerView addSubview:toVC.view];
    CGRect floatRect = CGRectMake(self.center.x - self.radius, self.center.y - self.radius, self.radius * 2, self.radius *2);
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:floatRect cornerRadius:self.radius];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-self.radius, -self.radius, FloatScreenWidth + self.radius * 2, FloatScreenHeight + self.radius * 2) cornerRadius:self.radius];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    toVC.view.layer.mask = maskLayer;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endPath.CGPath));
    maskLayerAnimation.duration = AnimationDuration;
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"xw_path"];
    
    self.coverView.alpha = 0;
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.coverView.alpha = 0.8;
    }];
}

#pragma mark Pop转场动画

- (void)animatePopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    [containerView insertSubview:toVC.view atIndex:0];
    
    NSNumber *popWithPanGesNumber = objc_getAssociatedObject([NSObject currentNavigationController], &kPopWithPanGes);
    BOOL popWithPanGes = [popWithPanGesNumber boolValue];
    if (popWithPanGes) {
        //模拟系统动画，底部view也有一个向右偏移动画
        toVC.view.x = -FloatScreenWidth / 4.0;
    }
    else {
        [toVC.view addSubview:self.coverView];
        
        CGRect floatRect = CGRectMake(self.center.x - self.radius, self.center.y - self.radius, self.radius * 2, self.radius *2);
        
        UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:floatRect cornerRadius:self.radius];
        CAShapeLayer *maskLayer = (CAShapeLayer *)fromVC.view.layer.mask;
        CGPathRef startPath = maskLayer.path;
        maskLayer.path = endPath.CGPath;
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.fromValue = (__bridge id)(startPath);
        maskLayerAnimation.toValue = (__bridge id)(endPath.CGPath);
        maskLayerAnimation.duration = AnimationDuration;
        maskLayerAnimation.delegate = self;
        [maskLayer addAnimation:maskLayerAnimation forKey:@"xw_path"];
        
        self.coverView.alpha = 1.0;
        [UIView animateWithDuration:AnimationDuration animations:^{
            self.coverView.alpha = 0;
        }];
    }
}

/** 替换新动画，用于手势拖动到某个位置，执行缩小动画 */
- (void)replaceAnimation
{
    self.coverView.alpha = 0;
    UIViewController *fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [fromVC.view addSubview:self.coverView];
    //当前fromVC.view有偏移，需要重置
    CGFloat currentX = fromVC.view.x;
    fromVC.view.x = 0;
    CGFloat endFloatX = self.center.x - self.radius;
    CGRect floatRect = CGRectMake(endFloatX, self.center.y - self.radius, self.radius * 2, self.radius *2);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(currentX, -self.radius, FloatScreenWidth + self.radius * 2, FloatScreenHeight + self.radius * 2) cornerRadius:self.radius];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:floatRect cornerRadius:self.radius];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(endPath.CGPath);
    maskLayerAnimation.duration = ContinueAnimationDuration;
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"xw_path"];
    
    [UIView animateWithDuration:ContinueAnimationDuration animations:^{
        self.coverView.alpha = 0.3;
        toVC.view.x = 0;
    }];
}

/** 继续执行动画，用于控制交互转场，手势结束个的动画执行 */
- (void)continueAnimationWithFastSliding:(BOOL)fastSliding
{
    UIViewController *fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGFloat duration = ContinueAnimationDuration;
    if (!fastSliding) {
        duration = (1 - fromVC.view.x / FloatScreenWidth) * AnimationDuration;
    }
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.x = FloatScreenWidth;
        toVC.view.x = 0;
    } completion:^(BOOL finished) {
        [self p_endAnimator];
    }];
}

/** 更新交互转场的进度 */
- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    fromVC.view.x = FloatScreenWidth * percentComplete;
    toVC.view.x =  -(FloatScreenWidth / 4.0 * (1- percentComplete));
}

/** 动画反转，用于手势拖动未达到pop条件时，将动画取消 */
- (void)cancelInteractiveTransition
{
    UIViewController *fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGFloat percentComplete = fromVC.view.x / FloatScreenWidth;
    [UIView animateWithDuration:AnimationDuration * percentComplete animations:^{
        fromVC.view.x = 0;
        toVC.view.x = -FloatScreenWidth / 4.0;
    } completion:^(BOOL finished) {
        toVC.view.x = 0;
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    }];
}

#pragma mark - Private

- (void)p_endAnimator
{
    [_coverView removeFromSuperview];
    if (_operation == UINavigationControllerOperationPop) {
        //执行完之后清理绑定，防止循环引用
        UIViewController *fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:AnimationDidEndKey object:fromVC];
    }
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //pop转场动画执行完，显示悬浮球
    if (_operation == UINavigationControllerOperationPop) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AnimationWillEndKey object:nil];
    }
    [self p_endAnimator];
}

#pragma mark - getter

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor blackColor];
    };
    return _coverView;
}

@end
