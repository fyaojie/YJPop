//
//  UIView+YJLayout.h
//  MobileEngine
//
//  Created by 申健 on 2018/6/1.
//

#import <UIKit/UIKit.h>

#define windowSafeAreaInsets \
({UIEdgeInsets windowSafeAreaInsets = UIEdgeInsetsZero;\
if (@available(iOS 11.0, *)) {\
windowSafeAreaInsets = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;\
}\
(windowSafeAreaInsets);})

#define HEXCOLOR(hexValue)              [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : 1.0]
#define Font(x) [UIFont systemFontOfSize:x]
#define ItalicFont(x) [UIFont italicSystemFontOfSize:x]
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]

/// 获取为0时,解释 https://blog.csdn.net/weixin_41847052/article/details/111300756
//获取iOS 11下view对应的safeAreaInsets,用于判断当前屏幕,需要一定的时机
static inline UIEdgeInsets cms_safeAreaInsetOfView(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

static inline UIEdgeInsets cms_safeAreaInset() {
    static dispatch_once_t onceToken;
    static UIWindow *window;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
    });
    if (@available(iOS 11.0, *)) {
        return window.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

@interface UIView (YJLayout)

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize size;

- (void)cms_removeAllSubviews;

/// 获取当前视图所在的vc
- (UIViewController *)cms_viewController;

@end
