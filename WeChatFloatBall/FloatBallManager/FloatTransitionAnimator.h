//
//  FloatTransitionAnimator.h
//  WebViewDemo
//
//  Created by TIM on 2018/8/30.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 转场动画类 */
@interface FloatTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

/** 转场动画类型 push/pop */
@property (nonatomic, assign) UINavigationControllerOperation operation;

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

/** 悬浮球圆心坐标 */
@property (nonatomic, assign, readonly) CGPoint center;
/** 悬浮球半径 */
@property (nonatomic, assign, readonly) CGFloat radius;
/** 遮罩 */
@property(nonatomic, strong, readonly) UIView *coverView;

+ (instancetype)animatorWithStartCenter:(CGPoint)center
                                 radius:(CGFloat)radius
                              operation:(UINavigationControllerOperation)operation;

- (instancetype)initWithStartCenter:(CGPoint)center
                             radius:(CGFloat)radius
                          operation:(UINavigationControllerOperation)operation;

/** 替换新动画，用于手势拖动到某个位置，执行缩小动画 */
- (void)replaceAnimation;
/** 继续执行动画，用于控制交互转场，手势结束个的动画执行 */
- (void)continueAnimationWithFastSliding:(BOOL)fastSliding;
/** 更新交互转场的进度 */
- (void)updateInteractiveTransition:(CGFloat)percentComplete;
/** 动画反转，用于手势拖动未达到pop条件时，将动画取消 */
- (void)cancelInteractiveTransition;

@end
