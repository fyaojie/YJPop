//
//  YJPopController.m
//  YJPopOC
//
//  Created by symbio on 2021/4/13.
//

#import "YJPopController.h"
#import "UIView+YJLayout.h"

@interface YJPopController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *backgroundView;
@end

@implementation YJPopController

+ (instancetype)alertControllerWithPreferredStyle:(YJPopControllerStyle)preferredStyle {
    YJPopController *pop = [[self alloc] init];
    pop.animatedDelegate = [[YJPopAnimation alloc] initWithPreferredStyle:preferredStyle];
    pop.transitioningDelegate = pop;
    pop.modalPresentationStyle = UIModalPresentationCustom;
    return pop;
}

- (void)pop {
    [[self currentViewController] presentViewController:self animated:YES completion:nil];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIViewController*)currentViewController{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (true) {
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = [(UITabBarController *)vc selectedViewController];
        } else if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else {
            break;
        }
    }
    return vc;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.contentView.frame = self.view.bounds;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        _contentView.backgroundColor = UIColor.whiteColor;
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _backgroundView.backgroundColor = UIColor.blackColor;
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackgroundView)]];
    }
    return _backgroundView;
}

- (void)didClickBackgroundView {
    if (self.didClickBackgroundCallback) {
        self.didClickBackgroundCallback();
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.animatedDelegate;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.animatedDelegate;
}

@end

@interface YJPopAnimation ()
@property (nonatomic, assign) YJPopControllerStyle preferredStyle;

@end

@implementation YJPopAnimation

- (instancetype)initWithPreferredStyle:(YJPopControllerStyle)preferredStyle {
    self = [super init];
    if (self) {
        self.preferredStyle = preferredStyle;
    }
    return self;
}

- (void)sheetAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!toViewController || !fromViewController) {
        return;
    }
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (toViewController.isBeingPresented) {
        if (![toViewController isKindOfClass:[YJPopController class]]) {
            return;
        }
        YJPopController *actionSheet = (YJPopController *)toViewController;
        actionSheet.view.height = actionSheet.contentView.height + windowSafeAreaInsets.bottom;
        [containerView addSubview:actionSheet.backgroundView];
        [containerView addSubview:actionSheet.view];
        actionSheet.view.top = containerView.height;
        actionSheet.backgroundView.alpha = 0;
        
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            actionSheet.view.bottom = containerView.height;
            actionSheet.backgroundView.alpha = 0.4;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else if (fromViewController.isBeingDismissed) {
        if (![fromViewController isKindOfClass:[YJPopController class]]) {
            return;
        }
        YJPopController *actionSheet = (YJPopController *)fromViewController;
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            actionSheet.backgroundView.alpha = 0;
            actionSheet.view.top = containerView.height;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

- (void)alertAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!toViewController || !fromViewController) {
        return;
    }
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (toViewController.isBeingPresented) {
        if (![toViewController isKindOfClass:[YJPopController class]]) {
            return;
        }
        YJPopController *actionSheet = (YJPopController *)toViewController;
        actionSheet.view.height = actionSheet.contentView.height;
        [containerView addSubview:actionSheet.backgroundView];
        [containerView addSubview:actionSheet.view];
        actionSheet.view.top = containerView.height;
        actionSheet.backgroundView.alpha = 0;
        
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            actionSheet.view.center = containerView.center;
            actionSheet.backgroundView.alpha = 0.4;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else if (fromViewController.isBeingDismissed) {
        if (![fromViewController isKindOfClass:[YJPopController class]]) {
            return;
        }
        YJPopController *actionSheet = (YJPopController *)fromViewController;
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            actionSheet.backgroundView.alpha = 0;
            actionSheet.view.top = containerView.height;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext preferredStyle:(YJPopControllerStyle)preferredStyle {
    if (preferredStyle == YJPopControllerStyleSheet) {
        [self sheetAnimateTransition:transitionContext];
    } else if (preferredStyle == YJPopControllerStyleAlert) {
        [self alertAnimateTransition:transitionContext];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [self animateTransition:transitionContext preferredStyle:(self.preferredStyle)];
}

@end
