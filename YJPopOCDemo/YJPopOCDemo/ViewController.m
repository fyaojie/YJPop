//
//  ViewController.m
//  YJPopOCDemo
//
//  Created by symbio on 2021/4/13.
//

#import "ViewController.h"
#import <YJPopOC/YJPopController.h>
#import <YJPopOC/YJMultiSelectActionSheet.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showSheet];
}

- (void)showBase {
    YJPopController *sheet = [YJPopController alertControllerWithPreferredStyle:(YJPopControllerStyleSheet)];
    [sheet pop];
}

- (void)showSheet {
    
    NSMutableArray *muarr = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        YJMultiSelectActionSheetItem *item = [[YJMultiSelectActionSheetItem alloc] init];
        item.cellHeight = 46;
        item.title = @"文字标题";
        [muarr addObject:item];
    }
    
    YJMultiSelectActionSheet *sheet = [YJMultiSelectActionSheet actionSheetWithTitle:@"主标题" items:muarr didSelectCallback:^(NSArray<YJMultiSelectActionSheetItem *> * _Nonnull selectItems) {
        NSLog(@"%ld", selectItems.count);
    }];
    [sheet pop];
}

@end
