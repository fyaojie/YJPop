//
//  YJPopController.h
//  YJPopOC
//
//  Created by symbio on 2021/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    YJPopControllerStyleAlert,
    YJPopControllerStyleSheet
} YJPopControllerStyle;

@interface YJPopController : UIViewController
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UIView *backgroundView;

@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> animatedDelegate;

/// 背景点击回调
@property (nonatomic, copy) void (^didClickBackgroundCallback)(void);

+ (instancetype)alertControllerWithPreferredStyle:(YJPopControllerStyle)preferredStyle;

- (void)pop;
- (void)dismiss;
@end


@interface YJPopAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithPreferredStyle:(YJPopControllerStyle)preferredStyle;

- (void)alertAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)sheetAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext preferredStyle:(YJPopControllerStyle)preferredStyle;
@end
NS_ASSUME_NONNULL_END
