//
//  GuideCell.m
//  myTest
//
//  Created by sss on 15/3/16.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "GuideCell.h"


#import "GuideStatus.h"
@interface GuideCell ()
@property (strong, nonatomic)  UIImageView *iconView;
@end
@implementation GuideCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = (CGRect){CGPointZero, frame.size};
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
    }
    return self;
}

- (void)setImage:(NSString *)ImageURl
{
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DomainURL,ImageURl]] placeholderImage:[UIImage imageNamed:@"tp_jiazai"]];
}


@end
