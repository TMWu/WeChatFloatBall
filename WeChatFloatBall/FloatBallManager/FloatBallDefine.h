//
//  FloatBallDefine.h
//  WebViewDemo
//
//  Created by TIM on 2018/8/29.
//  Copyright © 2018年 tim. All rights reserved.
//

#ifndef FloatBallDefine_h
#define FloatBallDefine_h

#define FloatScreenWidth  [UIScreen mainScreen].bounds.size.width
#define FloatScreenHeight  [UIScreen mainScreen].bounds.size.height

//悬浮球宽高
#define FloatWidth  60
//悬浮球靠边停留边距
#define FloatMargin 15
//右下角1/4圆半径
#define RoundViewRadius 170
//圆执行动画的半径变化
#define RoundViewOffset 10

//转场动画时间
#define AnimationDuration 0.35
//动画切换后的执行时间/快速滑动的pop动画时间
#define ContinueAnimationDuration 0.2
//悬浮、右下角圆出现动画时间
#define FloatTranslationInDuration 0.3
//悬浮、右下角圆消失动画时间
#define FloatTranslationOutDuration 0.2

#define AnimationWillBeginKey   @"AnimationWillBeginKey"
#define AnimationWillEndKey     @"AnimationWillEndKey"
#define AnimationDidEndKey      @"AnimationDidEndKey"

//定义了一个__weak的self_weak_变量
#define FloatWeakSelf    __weak __typeof(&*self)weakSelf = self;
//局域定义了一个__strong的self指针指向self_weak
#define FloatStrongSelf   __strong __typeof(&*weakSelf)self = weakSelf;

#define FloatWeakObject(__object)          __weak typeof(__object) weak_##__object = __object;

/** 检测block是否可用并执行 */
#define FloatBlockExec(block, ...) if (block) { block(__VA_ARGS__); };

#endif /* CommonDefine_h */
