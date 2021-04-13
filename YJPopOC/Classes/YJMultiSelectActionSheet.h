//
//  YJMultiSelectActionSheet.h
//  PopDemo
//
//  Created by symbio on 2021/4/6.
//

#import "YJPopController.h"
#import "YJMultiSelectActionSheetCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface YJMultiSelectActionSheet : YJPopController
@property (nonatomic, strong, readonly) UIButton *bottomBarButton;
+ (instancetype)actionSheetWithTitle:(nullable NSString *)title
                               items:(NSArray<YJMultiSelectActionSheetItem *> *)items
                   didSelectCallback:(void(^)(NSArray<YJMultiSelectActionSheetItem *> *selectItems))callback;;
@end

NS_ASSUME_NONNULL_END
