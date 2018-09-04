# WeChatFloatBall
一行代码实现高仿微信悬浮球

首先来看下微信上的效果： 

![微信](https://upload-images.jianshu.io/upload_images/5306625-6efbc87feeda1e69.GIF?imageMogr2/auto-orient/strip)  

再来看下我们的实现效果：  

![悬浮球](https://upload-images.jianshu.io/upload_images/5306625-37c8d8efe60dac55.GIF?imageMogr2/auto-orient/strip)

## 使用方式
1.如果你的项目没有类似如下代码：
`_navigationController.delegate`和`_navigationController.interactivePopGestureRecognizer.delegate`
也就是没有对`UINavigationController`和`UINavigationController`的右滑返回手势设置代理。  
那么你只需要添加一行代码就能集成...  
一行代码，真的只有一行：  
```
//添加要监控的类名
[[FloatBallManager shared] addFloatMonitorVCClasses:@[@"SecondViewController"]];
```
最好在`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`里添加。  

2.如果不巧的是，你的项目设置了上述两个代理（当然，大部分情况下都会设置）。不方，只要添加如下配置就好了：
```
#pragma mark - UINavigationControllerDelegate
#pragma mark 自定义转场动画
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

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[FloatBallManager shared] didShowViewController:viewController navigationController:navigationController];
}
```

更加详细的技术实现过程介绍，见[简书传送门](https://www.jianshu.com/p/d2145413db76)
