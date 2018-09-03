//
//  UIView+FloatFrame.h
//  WebViewDemo
//
//  Created by TIM on 2018/8/31.
//  Copyright © 2018年 TIM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FloatFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign, readonly) CGFloat middleX;
@property (nonatomic, assign, readonly) CGFloat middleY;
@property (nonatomic, assign, readonly) CGPoint middlePoint;

@end
