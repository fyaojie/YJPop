//
//  YJMultiSelectActionSheetCell.m
//  Demo
//
//  Created by symbio on 2021/3/31.
//

#import "YJMultiSelectActionSheetCell.h"
#import "UIView+YJLayout.h"

@interface YJMultiSelectActionSheetCell ()

@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation YJMultiSelectActionSheetCell

- (void)setItem:(YJMultiSelectActionSheetItem *)item {
    _item = item;
    self.selectButton.selected = item.selected;
    self.titleLabel.text = item.title;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectButton setImage:[self yj_imageName:@"checkbox_icon"] forState:(UIControlStateNormal)];
        [_selectButton setImage:[self yj_imageName:@"checkbox_select_icon"] forState:(UIControlStateSelected)];
        _selectButton.userInteractionEnabled = false;
        [self.contentView addSubview:_selectButton];
    }
    return _selectButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HEXCOLOR(0x333333);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HEXCOLOR(0xEEEEEE);
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.selectButton.frame = CGRectMake(16, 14, 18, 18);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.selectButton.frame) + 12, 0, self.contentView.bounds.size.width - CGRectGetMaxX(self.selectButton.frame) - 12, self.contentView.bounds.size.height);
    self.lineView.frame = CGRectMake(CGRectGetMinX(self.selectButton.frame), self.contentView.bounds.size.height - 0.5, self.contentView.bounds.size.width - CGRectGetMinX(self.selectButton.frame), 0.5);
}

- (UIImage *)yj_imageName:(NSString *)name {
    NSInteger scale = [UIScreen mainScreen].scale;
    NSBundle *refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"YJPopOC" ofType:@"bundle"]];
    UIImage *image = [UIImage imageWithContentsOfFile:[refreshBundle pathForResource:[NSString stringWithFormat:@"%@@%zdx.png", name, scale] ofType:nil]];
    return image;
}

@end
