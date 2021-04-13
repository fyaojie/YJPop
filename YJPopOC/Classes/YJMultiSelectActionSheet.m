//
//  YJMultiSelectActionSheet.m
//  PopDemo
//
//  Created by symbio on 2021/4/6.
//

#import "YJMultiSelectActionSheet.h"
#import "UIView+YJLayout.h"

const static NSUInteger maxCount = 8;

@interface YJMultiSelectActionSheet () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<YJMultiSelectActionSheetItem *> *items;

@property (nonatomic, strong) UIButton *bottomBarButton;

@property (nonatomic, copy) void(^didSelectCallback)(NSArray<YJMultiSelectActionSheetItem *> *selectItems);

@end

@implementation YJMultiSelectActionSheet

#pragma mark - life cycle

+ (instancetype)actionSheetWithTitle:(NSString *)title items:(NSArray<YJMultiSelectActionSheetItem *> *)items didSelectCallback:(void (^)(NSArray<YJMultiSelectActionSheetItem *> * _Nonnull))callback {
    YJMultiSelectActionSheet *actionSheet = [self alertControllerWithPreferredStyle:(YJPopControllerStyleSheet)];
    actionSheet.items = items;
    [actionSheet.bottomBarButton setTitleColor:HEXCOLOR(0xD9AE81) forState:(UIControlStateNormal)];
    actionSheet.didSelectCallback = callback;
    return actionSheet;
}

#pragma end

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items objectAtIndex:indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJMultiSelectActionSheetItem *item = self.items[indexPath.row];
    YJMultiSelectActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJMultiSelectActionSheetCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.width = tableView.width;
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJMultiSelectActionSheetItem *item = self.items[indexPath.row];
    item.selected = !item.selected;
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

#pragma end

#pragma mark - getter & setter

- (NSArray<YJMultiSelectActionSheetItem *> *)selectItems {
    NSMutableArray *selects = [NSMutableArray array];
    for (YJMultiSelectActionSheetItem *item in self.items) {
        if (item.selected) {
            [selects addObject:item];
        }
    }
    return selects;
}

- (void)setItems:(NSArray<YJMultiSelectActionSheetItem *> *)items {
    _items = items;
    
    __block CGFloat tableHeight = 0;
    
    [items enumerateObjectsUsingBlock:^(YJMultiSelectActionSheetItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < maxCount) {
            tableHeight += obj.cellHeight;
        }
    }];
    
    self.contentView.height = tableHeight + cms_safeAreaInsetOfView(self.view).bottom + 60;
    
    [self.tableView reloadData];
    [self scrollToSelectedItem];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        
        CGRect rect = self.contentView.bounds;
        rect.size.height = self.contentView.height - 60;
        
        _tableView = [[UITableView alloc] initWithFrame:rect];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YJMultiSelectActionSheetCell class] forCellReuseIdentifier:@"YJMultiSelectActionSheetCell"];
        [self.contentView addSubview:_tableView];
    }
    return _tableView;
}

- (UIButton *)bottomBarButton {
    if (!_bottomBarButton) {
        _bottomBarButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _bottomBarButton.frame = CGRectMake(0, self.contentView.height - 60, self.contentView.width, 60);
        [_bottomBarButton setTitle:@"确定" forState:(UIControlStateNormal)];
        [_bottomBarButton addTarget:self action:@selector(didClickRightBarButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_bottomBarButton];
    }
    return _bottomBarButton;
}

- (void)didClickRightBarButton {
    if (self.didSelectCallback) {
        self.didSelectCallback([self selectItems]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma end

#pragma mark - private methods

- (void)scrollToSelectedItem
{
    if (self.items.count <= maxCount) {
        return;
    }
    NSInteger index = [self indexOfSelectedItem];
    if (index == NSNotFound || index < 0 || index >= self.items.count) {
        return;
    }
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

- (NSInteger)indexOfSelectedItem
{
    for (NSInteger i = 0; i < self.items.count; i++) {
        if (self.items[i].selected) {
            return i;
        }
    }
    return NSNotFound;
}

#pragma end

@end

