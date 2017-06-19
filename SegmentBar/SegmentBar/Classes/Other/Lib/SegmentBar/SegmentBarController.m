//
//  SegmentBarController.m
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/31.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "SegmentBarController.h"
#import "UIView+Extension.h"

@interface SegmentBarController () <SegmentBarDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation SegmentBarController

- (SegmentBar *)segmentBar
{
    if (!_segmentBar) {
        
        SegmentBar *segmentBar = [SegmentBar segmentBarWithFrame:CGRectZero];
        segmentBar.delegate = self;
        self.view.backgroundColor = [UIColor brownColor];
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
        
    }
    return _segmentBar;
}
- (UIScrollView *)contentView
{
    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setUpWithItems:(NSArray<NSString *> *)items childvcs:(NSArray<UIViewController *> *)vcArr
{

    NSAssert(items.count !=0 || items.count == vcArr.count, @"个数不一致");
    
    self.segmentBar.items = items;
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    // 添加控制器，在contentView里面添加子控制器
    for (UIViewController *vc in vcArr) {
        [self addChildViewController:vc];
    }
    
    self.contentView.contentSize = CGSizeMake(items.count * self.view.width, 0);
    
    self.segmentBar.selectedIndex = 0;
    
    
}

- (void)showChildVcViewAtIndex:(NSInteger)index
{
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count -1) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:vc.view];
    
    
    // 滚动到对应的位置
    [self.contentView setContentOffset:CGPointMake(index*self.contentView.width, 0) animated:YES];;
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (self.segmentBar.superview == self.view) {
        self.segmentBar.frame = CGRectMake(0, 60, self.view.width, 35);
        
        CGFloat contentViewY = self.segmentBar.y + self.segmentBar.height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.height, self.view.height - contentViewY);
        self.contentView.frame = contentFrame;
        
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
        
        return;
        
    }
    
    CGRect contentFrame = CGRectMake(0, 0,self.view.width,self.view.height);
    self.contentView.frame = contentFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    
    // 其他的控制器视图, 大小
    // 遍历所有的视图, 重新添加, 重新进行布局
    // 注意: 1个视图
    //
    
    self.segmentBar.selectedIndex = self.segmentBar.selectedIndex;
    
    
}

#pragma mark -- 选项卡代理方法
- (void)segmentBar:(SegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    [self showChildVcViewAtIndex:toIndex];
}



#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算最后的索引
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    
    self.segmentBar.selectedIndex = index;
}


@end
