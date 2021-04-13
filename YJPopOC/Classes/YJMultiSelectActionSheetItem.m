//
//  YJMultiSelectActionSheetItem.m
//  Demo
//
//  Created by symbio on 2021/3/31.
//

#import "YJMultiSelectActionSheetItem.h"
#import "UIView+YJLayout.h"

@implementation YJMultiSelectActionSheetItem
- (instancetype)init
{
    if (self = [super init]) {
        self.cellHeight = 44;
        _iconFontColor = HEXCOLOR(0x5e87c1);
    }
    return self;
}
@end
