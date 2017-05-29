//
//  NoDownLoadView.m
//  SegmentBar
//
//  Created by 郭吉刚 on 17/5/28.
//  Copyright © 2017年 郭吉刚. All rights reserved.
//

#import "NoDownLoadView.h"

@interface NoDownLoadView ()
@property (weak, nonatomic) IBOutlet UIImageView *NoDownImage;

@end

@implementation NoDownLoadView

+ (instancetype)noDownLoadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"NoDownLoadView" owner:nil options:nil] lastObject];
}


- (void)setNoDataImg:(UIImage *)noDataImg
{
    _noDataImg = noDataImg;
    self.NoDownImage.image = noDataImg;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}


- (IBAction)click:(id)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
