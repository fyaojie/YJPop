//
//  YJMultiSelectActionSheetItem.h
//  Demo
//
//  Created by symbio on 2021/3/31.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YJMultiSelectActionSheetItem : NSObject
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *iconFont;

@property (nonatomic, strong) UIColor *iconFontColor;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, copy) NSString *cellClassName;

/// 记录关联参数
@property (nonatomic, strong) id parameter;
@end

NS_ASSUME_NONNULL_END
