//
//  SegmentBar.m
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/28.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "SegmentBar.h"
#import "UIView+Extension.h"

#define kMinMargin 30

@interface SegmentBar ()
{
    // 记录最后一次电机的按钮
    UIButton *_lastBtn;
}

// 内容承载式图
@property (nonatomic, weak) UIScrollView *contentView;

// 添加的按钮数据
@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;

// 指示器
@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, strong) SegmentBarConfig *config;

@end

@implementation SegmentBar

#pragma mark --接口
+ (instancetype)segmentBarWithFrame:(CGRect)frame
{
    SegmentBar *segmentBart = [[SegmentBar alloc] initWithFrame:frame];
    return segmentBart;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = self.config.segmentBarBackColor;
        
    }
    return self;
}

- (void)updateWithConfig:(void (^)(SegmentBarConfig *))configBlock
{
    if (configBlock) {
        configBlock(self.config);
    }
    
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.config.itemnormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemnormalColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
    }
    
    // 指示器
    self.indicatorView.backgroundColor = self.config.indicatorColor;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    // 锅炉数据
    if (self.itemBtns.count == 0 || selectedIndex < 0 || selectedIndex > self.itemBtns.count - 1) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    UIButton *btn = self.itemBtns[selectedIndex];
    [self btnClick:btn];
}

- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    
    // 删除之前过多的组件
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:self.config.itemnormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemnormalColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
        
    }
    
    // 手动刷新布局
    [self setNeedsDisplay];
    [self layoutIfNeeded];
    
}

#pragma mark --私有点击方法
- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectIndex:btn.tag fromIndex:_lastBtn.tag];
    }
    
    _selectedIndex = btn.tag;
    
    _lastBtn.selected = NO;
    btn.selected = YES;
    _lastBtn = btn;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = btn.width + self.config.indicatorExtraW * 2;
        self.indicatorView.centerX = btn.centerX;
    }];
    
    // 1.县滚动到btn位置
    CGFloat scrollX = btn.centerX - self.contentView.width * 0.5;
    
    if (scrollX < 0) {
        scrollX = 0;
    }
    
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
    
}

#pragma mark -- 布局

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    
    // 计算margin
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    
    CGFloat caculateMargin = (self.width - totalBtnWidth) / (self.items.count + 1);
    if (caculateMargin < kMinMargin) {
        caculateMargin = kMinMargin;
    }
    
    
    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemBtns) {
        // w, h
        [btn sizeToFit];
        // y 0
        // x, y,
        btn.y = 0;
        
        btn.x = lastX;
        
        lastX += btn.width + caculateMargin;
        
    }
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    if (self.itemBtns.count == 0) {
        return;
    }
    UIButton *btn = self.itemBtns[self.selectedIndex];
    self.indicatorView.width = btn.width + self.config.indicatorExtraW * 2;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.height = self.config.indicatorHeight;
    self.indicatorView.y = self.height - self.indicatorView.height;
}

#pragma mark --懒加载
- (NSMutableArray<UIButton *> *)itemBtns
{
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        
        CGFloat indicatorH = self.config.indicatorHeight;
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - indicatorH, 0, indicatorH)];
        indicatorView.backgroundColor = self.config.indicatorColor;
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
        
    }
    return _indicatorView;
}

- (UIScrollView *)contentView
{
    if (!_contentView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _contentView = scrollView;
        
    }
    return _contentView;
}

- (SegmentBarConfig *)config
{
    if (!_config) {
        _config = [SegmentBarConfig defaultConfig];
    }
    return _config;
}

@end
