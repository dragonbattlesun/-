//
//  ProductButton.m
//  TableViewSquaredDemo
//
//  Created by Rannie on 13-9-10.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "ProductButton.h"

#define RImageHeightPercent 0.7

@implementation ProductButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setExclusiveTouch:YES];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
       
        CGFloat imageX = 0;
        CGFloat imageY = 25;
        CGFloat imageW = contentRect.size.width ;
        CGFloat imageH = contentRect.size.height * RImageHeightPercent ;
        
        return CGRectMake(imageX, imageY, imageW, imageH);
    }else {
        
        CGFloat imageX = 0;
        CGFloat imageY = 5;
        CGFloat imageW = contentRect.size.width;
        CGFloat imageH = contentRect.size.height * RImageHeightPercent;
        
        return CGRectMake(imageX, imageY, imageW, imageH);
    
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 0;
    CGFloat y = contentRect.size.height * RImageHeightPercent + 5;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height * (1 - RImageHeightPercent);
    
    return CGRectMake(x, y, width, height);
}

@end
